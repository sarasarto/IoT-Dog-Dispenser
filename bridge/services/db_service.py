import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from constants import DISPENSER_ID, SERVICES_PATH
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from prediction import Prediction


class DatabaseService:
    
    def __init__(self):
        self.services_path = SERVICES_PATH
        self.cred = credentials.Certificate('bridge/services/' + self.services_path)
        self.db_ref = None

    def initialize_connection(self):
        firebase_admin.initialize_app(self.cred)
        self.db_ref = firestore.client()
        print('Collegamento con il database avvenuto con successo!')

    def get_doc_ref(self, collection_name, doc_id):
        doc_ref = self.db_ref.collection(collection_name).document(doc_id)
        return doc_ref

    def update_available_ration(self, collar_id, ration):
        animal_ref = self.get_doc_ref('Animal', collar_id)
        available_ration = self.get_available_ration(collar_id)

        #se la available diventa negativa allora la settiamo a 0
        #questo si verifica quando dall'app diamo la possibilità
        #di erogare più di quello a disposizione
        if(ration >= available_ration):
            available_ration = 0
        else:
            available_ration -= ration
    
        animal_ref.update({'availableRation':available_ration})

    def get_available_ration(self, collar_id):
        animal_ref = self.get_doc_ref('Animal', collar_id)
        animal = animal_ref.get().to_dict()
        print(animal)
        return animal['availableRation']

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
        
    def resetDispenserState(self, dispenser_ref):
        doc_ref = self.db_ref.collection('Dispenser').document(DISPENSER_ID)
        dispenser_ref['qtnRation'] = 0
        #RIMETTO A NULL L'ANIMALE INTERESSATO!
        dispenser_ref['collarId'] = None
        doc_ref.set(dispenser_ref)

    
    def add_prediction(self, collarId, qnt, dispenser_id):
        print("Aggiungo nella tabella di predizione")

        pred = Prediction(collar_id = collarId, qnt = qnt, dispenser_id = dispenser_id)
        self.db_ref.collection('Prediction').add(pred.to_dict())


    def getAllCollection(self, collection_name):
        doc_coll = self.db_ref.collection(collection_name).stream()
        #print("qua sono in db")
        #for doc in doc_coll:
        #    print(doc.to_dict())
        #print("fine db")
        return doc_coll
    
    def get_Dispenser_curr_foodState(self):
        dispenser_ref = self.get_doc_ref('Dispenser', DISPENSER_ID)
        dispenser = dispenser_ref.get().to_dict()
        return dispenser['food_state']

    def update_FoodStateDispenser(self):
        dispenser_ref = self.get_doc_ref('Dispenser', DISPENSER_ID)
        curr_foodState = self.get_Dispenser_curr_foodState()
        print('*************************\n')
        print(curr_foodState)

        if(curr_foodState == False):
            curr_foodState = True
        else:
            curr_foodState = False
    
        dispenser_ref.update({'food_state':curr_foodState})