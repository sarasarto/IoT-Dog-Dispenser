import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from constants import DISPENSER_ID, SERVICES_PATH
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from erogation import Erogazione
from notification import Notifica

class DatabaseService:
    
    def __init__(self):
        self.services_path = SERVICES_PATH
        self.cred = credentials.Certificate('bridge/services/' + self.services_path)
        self.db_ref = None

    def initialize_connection(self):
        firebase_admin.initialize_app(self.cred)
        self.db_ref = firestore.client()
        print('Collegamento con il database avvenuto con successo!\n')

    def get_doc_ref(self, collection_name, doc_id):
        doc_ref = self.db_ref.collection(collection_name).document(doc_id)
        return doc_ref

    def update_available_ration(self, collar_id, ration, is_animal_detected):
        animal_ref = self.get_doc_ref('Animal', collar_id)
        disp_ref = self.get_doc_ref('Dispenser', DISPENSER_ID)

        dispenser = disp_ref.get().to_dict()
        animal = animal_ref.get().to_dict()
        available_ration = animal['availableRation']
        food_counter = animal['foodCounter']
        rimasto_disp = dispenser['cibo_rimasto']

        if  is_animal_detected:
            food_counter += 1

        #se la available diventa negativa allora la settiamo a 0
        #questo si verifica quando dall'app diamo la possibilità
        #di erogare più di quello a disposizione
        if(ration >= available_ration):
            available_ration = 0            
        else:
            available_ration -= ration
        
        rimasto_disp -= ration 
    
        animal_ref.update({'availableRation':available_ration, 'foodCounter': food_counter})
        disp_ref.update({'cibo_rimasto': rimasto_disp})

    def get_available_ration(self, collar_id):
        animal_ref = self.get_doc_ref('Animal', collar_id)
        animal = animal_ref.get().to_dict()
        return animal['availableRation']

    def get_food_counter(self, collar_id):
        animal_ref = self.get_doc_ref('Animal', collar_id)
        animal = animal_ref.get().to_dict()
        return animal['foodCounter']

    def get_nameAnimal_fromCollar(self, collar_id):
        animal_ref = self.get_doc_ref('Animal', collar_id)
        animal = animal_ref.get().to_dict()
        return animal['name']

    #funzione utile nel caso non usiamo gli ibeacon
    def get_user_animals(self, user_id):
        collar_id_list = []
        animals_ref = self.db_ref.collection('Animal')
        query = animals_ref.where('userId', '==', user_id)
        animals = query.stream()
        for animal in animals:
            collar_id_list.append(animal.to_dict()['collarId'])
        
        return collar_id_list

    def get_user_from_dispenser(self):
        dispenser_ref = self.get_doc_ref('Dispenser', DISPENSER_ID)
        dispenser = dispenser_ref.get().to_dict()
        return dispenser['userId']
        
    def reset_dispenser_state(self, dispenser_ref):
        doc_ref = self.db_ref.collection('Dispenser').document(DISPENSER_ID)
        dispenser_ref['qtnRation'] = 0
        #RIMETTO A NULL L'ANIMALE INTERESSATO!
        dispenser_ref['collarId'] = None
        doc_ref.set(dispenser_ref)

    
    def add_prediction(self, collarId, qnt, dispenser_id):
        print("Raccolta dati sull' erogazione...")

        pred = Erogazione(collar_id = collarId, qnt = qnt, dispenser_id = dispenser_id)
        self.db_ref.collection('Erogation Data').add(pred.to_dict())


    def getAllCollection(self, collection_name):
        doc_coll = self.db_ref.collection(collection_name).stream()
        return doc_coll
    
    def get_Dispenser_curr_foodState(self):
        dispenser_ref = self.get_doc_ref('Dispenser', DISPENSER_ID)
        dispenser = dispenser_ref.get().to_dict()
        return dispenser['food_state']

    def update_FoodStateDispenser(self, val):
        dispenser_ref = self.get_doc_ref('Dispenser', DISPENSER_ID)
        curr_foodState = self.get_Dispenser_curr_foodState()
       

        if(val == False):
            #c'erano i croccantini, ora cambio stato
            curr_foodState = True
            #qua il led dovrebbe essere acceso
            print("LED SI ACCENDE --- RISCHIO CROCCANTINI")
            #inserisco la notifica per utente
            self.set_notifica()

        else:
            #mancavano i crocc ma li ho aggiunti
            curr_foodState = False
            self.delete_notifica()
    
        dispenser_ref.update({'food_state':curr_foodState})

    def set_notifica(self):
        dispenser_ref = self.get_doc_ref('Dispenser', DISPENSER_ID)
        user_id = dispenser_ref.get().to_dict()['userId']
        notifica = Notifica(dispenser_id = DISPENSER_ID, user_id =user_id )
        print("Invio notifica in corso...")
        self.db_ref.collection('Notifiche').document(DISPENSER_ID).set(notifica.to_dict())

    def delete_notifica(self):
        dispenser_ref = self.get_doc_ref('Dispenser', DISPENSER_ID)
        doc_ref = self.db_ref.collection('Notifiche').document(DISPENSER_ID)
        print("STO ELIMINANDO LA NOTIFICA PER L'UTENTE")
        doc_ref.delete()
