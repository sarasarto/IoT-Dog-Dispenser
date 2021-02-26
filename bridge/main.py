from services.db_service import DatabaseService
from bridge import Bridge
from client import Client
import threading


def main():
    #inizializzo il collegamento con firestore
    db_service = DatabaseService()
    bridge = Bridge()
    client = Client(db_service)
    bridge.setup_serial()
    client.connect_to_database()

    #VA BENE UGUALMENTE QUESTO?
    #CIOE' CLASSI CHE HANNO UN RIFERIMENTO VERSO L'ALTRA?
    bridge.set_client(client)
    client.set_bridge(bridge)
    client.listen_dispenser_updates()
    
    bridge_thread = threading.Thread(target=bridge.loop)
    client_thread = threading.Thread(target=client.loop)

    bridge_thread.daemon = True
    client_thread.daemon = True

    bridge_thread.start()
    client_thread.start()

    
    while(True):
        pass

if __name__ == '__main__':
    main()