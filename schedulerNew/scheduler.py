from db_scheduler import DatabaseService
import schedule
import time

class Scheduler:
    def __init__(self, db_service):
        self.db_service = db_service
    
    def connect_to_database(self):
        self.db_service.initialize_connection()

    def reset_midnight(self):       
       animal_ref = self.db_service.db_ref.collection('Animal').stream()
       #print("Entro midnight")
       for animal in animal_ref:
           print(animal.to_dict()['name'])
           cur = animal.to_dict()
           #animal.update({'availableRation':cur['dailyRation']})
           self.db_service.db_ref.collection('Animal').document(cur['collarId']).update({'availableRation': cur['dailyRation'],'foodCounter': 0})

    #def prova_caso(self):
    #     print("Ciao ciao uei")

    def change(self):
        #print("sono in change")
        #questo per prova
        #schedule.every(15).seconds.do(self.reset_midnight)
        schedule.every().day.at("00:00").do(self.reset_midnight)
        
        while True:
            schedule.run_pending()
            time.sleep(1)
    