from firebase_admin.firestore import client
from services.db_service import DatabaseService
from serial.tools import list_ports
import serial
import random
from constants import  DISPENSER_ID, DEFAULT_RATION
from datetime import datetime
                                                                                                                                                                             
class Bridge:
    def __init__(self):
        self.ser = None
        self.port_name = None
        self.client = None
        self.dispenser_ref = None
        self.is_animal_detected = False
        self.qtn_ration = 0
        self.collar_id = None
        

    def set_client(self, client):
        self.client = client

    def setup_serial(self):
        print('List of available ports: ')

        ports = list_ports.comports()
        for port in ports:
            print('--> ' + port.device + port.description)
            if 'com' in port.description.lower():
                self.port_name = port.device

        if self.port_name is not None:
            print('Connecting to ' + self.port_name + '...')
            self.ser = serial.Serial(self.port_name, timeout=0)
            print('Connected with success!')
        else:
            print('No available ports!')


    def write(self, data):
        self.ser.write(data.encode())


    def loop(self):
        # infinite loop
        while (True):
            #look for a byte from serial
            if self.ser.in_waiting>0:
                # data available from the serial port
                lastchar=self.ser.read(1)
                self.useData(lastchar)
                  
         

    def useData(self, lastchar):
        animals = self.client.get_user_animals()
        command = int.from_bytes(lastchar, byteorder='little')

        # I have received a line from the serial port. I can use it
        if command == 1:
            self.collar_id = random.choice(animals)
            name = self.client.get_nameAnimal_fromCollar(self.collar_id)
            
            print("Rilevato animale vicino al dispenser!")
            print('Id collare: ' + self.collar_id)
            print('Nome animale: ' + name)
            
            #faccio tutte le verfiche del caso tramite il client
            print('Verifica in corso...')
            
            is_available = self.client.is_available(self.collar_id)
            if is_available:
                print('Erogazione in corso...')
                self.is_animal_detected = True
                self.write('1')

            else:
                print('Erogazione non effettuata causa soglia o razione insufficiente!')
                        
        else:
            if command == 6:
                #false food_state
                print('Si stanno esaurendo i croccantini!!!')
                self.client.update_FoodStateDispenser(False)
            else:
                if command==7:
                    print('Il dispenser è rifornito')
                    self.client.update_FoodStateDispenser(True)
                else:
                    if command == 2:
                        print('Erogazione effettuata con successo')
                        if(self.is_animal_detected is True):
                            print('Aggiorno in seguito ad avvicinamento')
                            self.client.update_available_ration(self.collar_id, DEFAULT_RATION, self.is_animal_detected)
                            self.is_animal_detected = False
                            self.collar_id = None
                        else:
                            print('Aggiorno in seguito a comando immediato')
                            self.client.update_available_ration(self.collar_id, self.qtn_ration, self.is_animal_detected)
                            self.client.add_prediction(self.collar_id, self.qtn_ration, DISPENSER_ID)
                            self.qtn_ration = 0
                            self.collar_id = None
                            self.client.reset_dispenser_state(self.dispenser_ref)
                       
                    else:
                        print('Attenzione, si è verificata un\' anomalia')

            
