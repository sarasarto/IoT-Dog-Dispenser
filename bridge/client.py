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

            #ci sarà da leggere anche l'id animale interessato

            if(qtnRation != 0):
                print('erogati')
                #da qui andrò ad erogare verso arduino
                self.bridge.write_msg('1') #erogo!!!!!!!

                #LEGGO ACK DA ARDUINO
                #IF OK --> SOTTRAGGO LA QTNRATION DALLA AVAILABLE RATION
                #IF NOT OK --> NON FACCIO NULLA MA RESETTO COMUNQUE LO STATO DEL DISPENSER
                #RIMETTENDO A ZERO LA QTNRATION E RESETTANDO IL RELATIVO ANIMALE A NULL

                #PROBLEMA: COME MI METTO IN COMUNICAZIONE CON IL BRIDGE PER CAPIRE SE E' ANDATO TUTTO
                #OK OPPURE NO????

                self.db_service.resetDispenserState(dispenser_ref)
        
       
    def loop(self):
        #il client rimane attivo per eventuali modifiche al db
        
        print('client thread')
        while(True):
            pass