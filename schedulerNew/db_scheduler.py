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

    def getAllCollection(self, collection_name):
        doc_coll = self.db_ref.collection(collection_name).stream()
        print("qua sono in db")
        for doc in doc_coll:
            print(doc.to_dict())
        return doc_coll