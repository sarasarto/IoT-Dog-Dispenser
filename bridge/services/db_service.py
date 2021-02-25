import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from constants import DISPENSER_ID, SERVICES_PATH
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore


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



#TODO: RIMETTERE A NULL L'ANIMALE INTERESSATO!

    def update_available_ration(self, collar_id, ration):
        animal_ref = self.get_doc_ref('Animal', collar_id)
        available_ration = self.get_available_ration(collar_id)
        if(ration >= available_ration):
            available_ration = 0
        else:
            available_ration -= ration
            
        #aggiorno la quantità
        #todo: se la available diventa negativa allora la settiamo a 0
        #questo si verifica quando dall'app diamo la possibilità
        #di erogare più di quello a disposizione

        animal_ref.update({'availableRation':available_ration})


    def get_available_ration(self, collar_id):
        animal_ref = self.get_doc_ref('Animal', collar_id)
        animal = animal_ref.get().to_dict()
        print(animal)
        return animal['availableRation']
        
    def resetDispenserState(self, dispenser_ref):
        doc_ref = self.db_ref.collection('Dispenser').document(DISPENSER_ID)
        dispenser_ref['qtnRation'] = 0
        dispenser_ref['collarId'] = None
        doc_ref.set(dispenser_ref)