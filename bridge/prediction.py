from datetime import datetime

class Prediction(object):
    def __init__(self, collar_id, qnt , dispenser_id ):
        self.datetime = datetime.now()
        self.collar_id = collar_id
        self.qnt = qnt
        self.dispenser_id = dispenser_id

    def to_dict(self):
        dest = {
            u'date_time': self.datetime,
            u'collar_id': self.collar_id,
            u'quantity': self.qnt,
            u'dispenserId': self.dispenser_id
        }
        return dest