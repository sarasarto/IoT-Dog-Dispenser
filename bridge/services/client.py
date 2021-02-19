from services.db_service import DatabaseService
from constants import  DISPENSER_ID
from bridge import Bridge

class Client:
    def __init__(self, bridge, db_service):
        self.db_service = db_service
        self.bridge = bridge

    def connect_to_database(self):
        self.db_service.initialize_connection()
    
    def listen_dispenser_updates(self):
        doc_ref = self.db_service.get_doc_ref(collection_name='Dispenser', doc_id=DISPENSER_ID)
        doc_ref.on_snapshot(self._on_snapshot_dispenser)

    def _on_snapshot_dispenser(self, doc_snapshot, changes, read_time):
        #NB: DOC_REF E' UNA LISTA CHE CONTIENE SOLO IL DISPENSER DI INTERESSE
        if(len(doc_snapshot) > 0):
            dispenser_ref = doc_snapshot[0].to_dict()
            qtnRation = dispenser_ref['qtnRation']

            if(qtnRation != 0):
                print('erogati')
                #da qui andrò ad erogare verso arduino
                #successivamente resetto a zero la variabile qtnRation
                self.db_service.resetDispenserState(dispenser_ref)
        
       