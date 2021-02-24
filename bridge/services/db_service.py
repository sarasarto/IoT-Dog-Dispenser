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
        self.cred = credentials.Certificate('services/' + self.services_path)
        self.db_ref = None

    def initialize_connection(self):
        firebase_admin.initialize_app(self.cred)
        self.db_ref = firestore.client()
        print('Collegamento con il database avvenuto con successo!')


    def get_doc_ref(self, collection_name, doc_id):
        doc_ref = self.db_ref.collection(collection_name).document(doc_id)
        return doc_ref



#TODO: RIMETTERE A NULL L'ANIMALE INTERESSATO!

    def update_animal_ration(self, collar_id, ration):
        animal_ref = self.get_doc_ref('Animal', collar_id)
        available_ration = self.get_animal_ration(collar_id)
        available_ration -= ration
        #aggiorno la quantità
        animal_ref.update({'availableRation':available_ration})


    def get_animal_ration(self, collar_id):
        animal_ref = self.get_doc_ref('Animal', collar_id)
        animal = animal_ref.get().to_dict()
        return animal['availableRation']
        
    def resetDispenserState(self, dispenser_ref):
        doc_ref = self.db_ref.collection('Dispenser').document(DISPENSER_ID)
        dispenser_ref['qtnRation'] = 0
        doc_ref.set(dispenser_ref)