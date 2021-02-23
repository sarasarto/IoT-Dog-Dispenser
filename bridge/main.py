from services.db_service import DatabaseService
from bridge import Bridge
from client import Client
import threading


def main():
    #inizializzo il collegamento con firestore
    db_service = DatabaseService()
    bridge = Bridge()
    client = Client(bridge, db_service)
    bridge.setup_serial()
    client.connect_to_database()
    client.listen_dispenser_updates()

    """
    bridge_thread = threading.Thread(target=bridge.loop)
    client_thread = threading.Thread(target=client.loop)

    bridge_thread.daemon = True
    client_thread.daemon = True

    bridge_thread.start()
    client_thread.start()
    """



    #while(True):
        #pass

    client.update_animal_ration('mio animale', 10)

if __name__ == '__main__':
    main()