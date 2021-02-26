from db_scheduler import DatabaseService
from scheduler import Scheduler

def main():
    #inizializzo il collegamento con firestore
    db_service = DatabaseService()
    scheduler = Scheduler(db_service)
    scheduler.connect_to_database()

    #client_thread = threading.Thread(target=client.loop)
    #client_thread.daemon = True
    #client_thread.start()

    #schedule.every().day.at("00:00").do(reset_midnight)
    schedule.every(10).seconds.do(scheduler.prova_caso)

    while 1:
        schedule.run_pending()
        time.sleep(1)
    
    
    #while(True):
     #   pass

if __name__ == '__main__':
    main()