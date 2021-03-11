from services.db_service import DatabaseService
from scheduler import Scheduler
import schedule
import time


def main():
    #inizializzo il collegamento con firestore
    db_service = DatabaseService()
    
    #istanzio lo scheduler
    scheduler = Scheduler(db_service)
    scheduler.connect_to_database()
    #chiamo il change ogni mezzanotte
    scheduler.listen_updates()
    

    # Watch the collection query
    
    print('OOOOOOOK')
    scheduler.change()

    
    
    #forse questo ciclo infinito si puo togliere visto 
    #che c'è già nella funzione change
    while(True):
       pass

if __name__ == '__main__':
    main()