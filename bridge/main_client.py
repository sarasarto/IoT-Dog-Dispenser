from services.db_service import DatabaseService
from bridge import Bridge
from services.client import Client


def main():
    #inizializzo il collegamento con firestore
    db_service = DatabaseService()
    bridge = Bridge()
    bridge.setup_serial()
    client = Client(bridge, db_service)
    client.connect_to_database()
    client.listen_dispenser_updates()

    while(True):
        pass

    

if __name__ == '__main__':
    main()