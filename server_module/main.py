from services.db_service import DatabaseService
from scheduler import ServerScheduler
import schedule
import time


def main():
    #inizializzo il collegamento con firestore
    db_service = DatabaseService()
    
    #istanzio lo scheduler
    scheduler = ServerScheduler(db_service)
    scheduler.connect_to_database()
    #chiamo il change ogni mezzanotte
   
    scheduler.listen_updates()
    scheduler.start_scheduler()

    

if __name__ == '__main__':
    main()