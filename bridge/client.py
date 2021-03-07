from services.db_service import DatabaseService
from constants import  DISPENSER_ID, DEFAULT_RATION
from bridge import Bridge
from datetime import datetime
class Client:
    def __init__(self, db_service):
        self.db_service = db_service
        self.bridge = None

    def set_bridge(self, bridge):
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
            #lo leggo in questo modo
            #si suppone di inserire nella tabella dispenser
            #oltre a qtn ration id collare dell'animale interessato
    
            collar_id = dispenser_ref['collarId']

            if qtnRation != 0 and collar_id != None:
                #da qui andrò ad inviare il comando ad arduino per erogare
                #non so però ancora se andrà a buon fine.
                #inviamo--> ff/02/01/qtn/fe
                
                # self.bridge.write(b'\xff')
                # self.bridge.write(b'\x02')
                # self.bridge.write(b'\x01')
                # self.bridge.write(qtnRation)
                # self.bridge.write(b'\xfe')

                self.bridge.write('1')
                
                #LEGGO ACK DA ARDUINO ---> come lo implemento???
                #IF arduino ha ricevuto --> SOTTRAGGO LA QTNRATION DALLA AVAILABLE RATION
                #if(...):
                # IN QUESTO CASO L'EROGAZIONE AVVIENE PERCHE UTENTE HA CHIESTO EROGAZIONE
                # NON PERCHE ANIMALE AVVICINATO
                avvicinato= False
                self.update_available_ration(collar_id, qtnRation, avvicinato)
                #IF NOT OK --> NON FACCIO NULLA MA RESETTO COMUNQUE LO STATO DEL DISPENSER
                #RIMETTENDO A ZERO LA QTNRATION E RESETTANDO IL RELATIVO ANIMALE A NULL

                #INOLTRE POPOLIAMO TABELLA PER LE PREDIZIONI ADDPREDICTION(?)
                self.add_prediction(collar_id, qtnRation, DISPENSER_ID)
                

                #PROBLEMA: COME MI METTO IN COMUNICAZIONE CON IL BRIDGE PER CAPIRE SE E' ANDATO TUTTO
                #OK OPPURE NO????

                self.db_service.resetDispenserState(dispenser_ref)


    #funzione che viene invocata quando animale si avvicina al dispenser
    #e di conseguenza bisogna verificare che abbia ancora razione disponibile
    def get_available_ration(self, collar_id):
        return self.db_service.get_available_ration(collar_id)
    
    def get_food_counter(self, collar_id):
        return self.db_service.get_food_counter(collar_id)

    #funziona che viene eseguita una volta ricevuto 
    #ACK dal microcontrollore
    #OSSERVAZIONE: IN QUESTO CASO NON SERVE CONTROLLARE
    #SE ANIMALE HA ABBASTANZA QUANTITA' XK VIENE GIà
    #FATTO DALL' APP---> e' giusta questa osservazione??
    def update_available_ration(self, collar_id, ration, avvicinato):
        self.db_service.update_available_ration(collar_id, ration, avvicinato)

    def is_available(self, collar_id):
        #supponiamo per il momento che si eroga solo
        #una quantità di 30 alla volta
        available_ration = self.get_available_ration(collar_id)
        food_counter = self.get_food_counter(collar_id)
        if food_counter >= 3:
            print("Si è gia raggiunta la soglia giornaliera di 3 volte!")
            return False
        #qua ho gia il controllo del food counter
        return True if available_ration >= DEFAULT_RATION else False

    def get_user_animals(self):
        user_id = self.db_service.get_user_from_dispenser()
        return self.db_service.get_user_animals(user_id)

    def get_user_from_dispenser(self):
        return self.db_service.get_user_from_dispenser()

    def get_nameAnimal_fromCollar(self, collar_id):
        return self.db_service.get_nameAnimal_fromCollar(collar_id)

       
    def loop(self):
        #il client rimane attivo per eventuali modifiche al db
        
        print('client thread')
        while(True):
            pass
    
    def add_prediction(self, collarId, qnt, dispenser_id):
        return self.db_service.add_prediction(collarId, qnt, dispenser_id)

    def update_FoodStateDispenser(self):
        return self.db_service.update_FoodStateDispenser()

    

