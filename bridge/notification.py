from datetime import datetime

class Notifica(object):
    def __init__(self, dispenser_id ):
        self.datetime = datetime.now()
        self.dispenser = dispenser_id

    def to_dict(self):
        dest = {
            u'date_time': self.datetime,
            u'dispenserId': self.dispenser_id
        }
        return dest