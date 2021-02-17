import threading
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

services_path = 'dogx-9703b-firebase-adminsdk-30k5j-b74bd82c2c.json'

# Use a service account
cred = credentials.Certificate('services/' + services_path)
firebase_admin.initialize_app(cred)

db = firestore.client()
print('collegamento fatto')

"""
MODO PER AGGIUNGERE UN DOCUMENTO AL DATABASE

doc_ref = db.collection('Animal').document('docId')
doc_ref.set({
    'collarId': 'collare',
    'name': 'max',
    'dailyRation': 100,
    'availableRation': 100,
    'userId': 'utente'
})

MODO PER LEGGERE DA UN'INTERA COLLEZIONE

animals_ref = db.collection('Animal')
docs = animals_ref.stream()

for doc in docs:
    print(f'{doc.id} => {doc.to_dict()}')
"""


# Create an Event for notifying main thread.
callback_done = threading.Event()

# Create a callback on_snapshot function to capture changes
def on_snapshot(doc_snapshot, changes, read_time):
    for doc in doc_snapshot:
        print(f'Received document snapshot: {doc.id}')
    callback_done.set()

doc_ref = db.collection('Animal').document('mio animale')

# Watch the document
doc_watch = doc_ref.on_snapshot(on_snapshot)

while(True):
    pass
  