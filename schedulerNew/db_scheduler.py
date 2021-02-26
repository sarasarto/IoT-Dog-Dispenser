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
        self.cred = credentials.Certificate(self.services_path)
        self.db_ref = None

    def initialize_connection(self):
        firebase_admin.initialize_app(self.cred)
        self.db_ref = firestore.client()
        print('Collegamento con il database avvenuto con successo!')

    def getAllCollection(self):
        doc_coll = self.db_ref.collection(collection_name)
        return doc_coll