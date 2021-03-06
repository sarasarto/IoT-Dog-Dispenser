from firebase_admin import credentials
from firebase_admin import firestore
from constants import DISPENSER_ID, SERVICES_PATH, file_name
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from prophet_prediction import Prophet_Prediction
from prediction_hours import Hour_Prediction


class DatabaseService:
    
    def __init__(self):
        self.services_path = SERVICES_PATH
        self.cred = credentials.Certificate("server_module/" + self.services_path)
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

    def activate_erogation(self, dispenser_id, collar_id, qtn_ration, doc_id_erogation):
        print("sto attivando erogazione")
        dispenser_ref = self.db_ref.collection('Dispenser').document(dispenser_id)
        dispenser_ref.update({'collarId':collar_id, 'qtnRation': qtn_ration})

        self.db_ref.collection('Programmed Erogation').document(doc_id_erogation).delete()
        #print(doc_ref)
        #a questo punto sarà compito del client ascoltare le modifiche al db per effetuare erogazione

    def add_fbp_prediction(self, prediction):
        print("Aggiungo nella tabella di predizione di prophet")
        pred = Prophet_Prediction(prediction=prediction)
        self.db_ref.collection('Predicted Erogation').add(pred.to_dict())

    def get_hour_prediction(self):
        print("sono del db per prendere ora")
        model = Hour_Prediction(file_name)
        h_pred= model.do_pred()
        print("**************previsione fatta")
        print(h_pred)
        return h_pred
