from db_scheduler import DatabaseService
#from constants import  DISPENSER_ID, DEFAULT_RATION
#from bridge import Bridge

class Scheduler:
    def __init__(self, db_service):
        self.db_service = db_service
        #self.bridge = None

    def reset_midnight():
       animal_ref = self.getAllCollection('Animal')
       for animal in animal_ref:
           curr = animal.get().to_dict()
           cur['availableRation'] = cur['dailyRation']
           animal_ref.set(cur)

    def prova_caso():
         print("Ciao")