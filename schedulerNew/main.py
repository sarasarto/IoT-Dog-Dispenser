from db_scheduler import DatabaseService
from scheduler import Scheduler
import schedule
import time


def main():
    #inizializzo il collegamento con firestore
    db_service = DatabaseService()
    
    #istanzio lo scheduler
    sched = Scheduler(db_service)
    sched.connect_to_database()

    print("iniziamo")
    #chiamo il change ogni mezzanotte
    sched.change()
    
    while(True):
       pass

if __name__ == '__main__':
    main()