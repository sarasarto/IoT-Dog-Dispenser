from datetime import datetime

class Notifica(object):
    def __init__(self, dispenser_id ,user_id):
        self.datetime = datetime.now()
        self.dispenser_id = dispenser_id
        self.user_id = user_id

    def to_dict(self):
        dest = {
            u'date_time': self.datetime,
            u'dispenserId': self.dispenser_id,
            u'user_id': self.user_id
        }
        return dest