from datetime import datetime
import schedule
import time

class ServerScheduler:
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
        progr_erogation = self.db_service.db_ref.collection('Programmed Erogation')
        progr_erogation.on_snapshot(self.on_snapshot_programmed)

        pred_erogation = self.db_service.db_ref.collection('Predicted Erogation')
        pred_erogation.on_snapshot(self.on_snapshot_predicted)

   
    def on_snapshot_programmed(self, col_snapshot, changes, read_time):
        for change in changes:
            if change.type.name == 'ADDED':
                #adesso non resta che salvare data ora in una coda e attivare 
                #lo scheduler a quelle ore e poi eliminare dalla coda e dal db
                document = change.document.to_dict()
                date = document['date']
                time = document['time']
                dispenser_id = document['dispenserId']
                collar_id = document['collarId']
                qtn_ration = document['qtnRation']

                print('Prevista nuova erogazione il: ' + date + ' ' + time)


            elif change.type.name == 'MODIFIED':
                print(f'Modified erogation: {change.document.id}')
            elif change.type.name == 'REMOVED':
                print(f'Removed erogation: {change.document.id}')

    def on_snapshot_predicted(self, col_snapshot, changes, read_time):
        for change in changes:
            if change.type.name == 'ADDED':
                #adesso non resta che salvare data ora in una coda e attivare 
                #lo scheduler a quelle ore e poi eliminare dalla coda e dal db
                document = change.document.to_dict()
                date = document['date']
                time = document['predicted_hour']
                collar_id = document['collar_id']
                
                print('Nuova erogazione predetta per il: ' + str(date) + ' ' + str(time))


            elif change.type.name == 'MODIFIED':
                print(f'Modified erogation: {change.document.id}')
            elif change.type.name == 'REMOVED':
                print(f'Removed erogation: {change.document.id}')       

    def start_scheduler(self):
        #self.sched.add_job(self.reset_animal_parameters, trigger='cron', hour='13', minute='58')
        #self.sched.add_job(self.do_prophet_prediction, trigger='cron', hour='14', minute='08')
        schedule.every().day.at("00:00").do(self.reset_animal_parameters)

        schedule.every().day.at("15:15").do(self.do_prophet_prediction)
        #schedule.every(5).seconds.do(self.do_prophet_prediction)
        
        while True:
            schedule.run_pending()
            time.sleep(1)
       


