from db_scheduler import DatabaseService
import schedule
import time

class Scheduler:
    def __init__(self, db_service):
        self.db_service = db_service
    
    def connect_to_database(self):
        self.db_service.initialize_connection()

    def set_time_erogazione(self):       
       animal_ref = self.db_service.db_ref.collection('Animal').stream()


    #def prova_caso(self):
    #     print("Ciao ciao uei")

    def change(self, TimeOfDay time):
        #print("sono in change")
        print(time)
        #schedule.every().day.at(time).do(self.set_time_erogazione)

        while True:
            schedule.run_pending()
            time.sleep(1)
    