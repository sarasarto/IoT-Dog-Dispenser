import schedule
import time


class Scheduler:
    def __init__(self, db_service):
        self.db_service = db_service
    
    def connect_to_database(self):
        self.db_service.initialize_connection()

    #a mezzanotte resetto la quantità disponibile 
    #e il food counter
    def reset_animal_parameters(self):       
        animal_ref = self.db_service.db_ref.collection('Animal').stream()
        for animal in animal_ref:
            cur = animal.to_dict()
            self.db_service.db_ref.collection('Animal').document(cur['collarId']).update({'availableRation': cur['dailyRation'],'foodCounter': 0})
        print('Effettuato il reset dei parametric degli animali!')
        

    def do_prophet_prediction(self):
        print("entro per prendere l'ora predetta")

        #faccio la predizione e la scrivo sul db
        h_pred = self.db_service.get_hour_prediction()
        self.db_service.add_fbp_prediction(h_pred)

    def listen_updates(self):
        col_query = self.db_service.db_ref.collection('Programmed Erogation')
        col_query.on_snapshot(self.on_snapshot_changes)
   
    def on_snapshot_changes(self, col_snapshot, changes, read_time):
        for change in changes:
            if change.type.name == 'ADDED':
                print(f'New erogation: {change.document.id}')
                #adesso non resto che salvare data ora in una coda e attivare 
                #lo scheduler a quelle ore e poi eliminare dalla coda e dal db

            elif change.type.name == 'MODIFIED':
                print(f'Modified erogation: {change.document.id}')
            elif change.type.name == 'REMOVED':
                print(f'Removed erogation: {change.document.id}')


    def change(self):
        schedule.every().day.at("00:00").do(self.reset_animal_parameters)

        schedule.every().day.at("00:00").do(self.do_prophet_prediction)
        #schedule.every(5).seconds.do(self.do_prophet_prediction)
        
        while True:
            schedule.run_pending()
            time.sleep(1)
    
    