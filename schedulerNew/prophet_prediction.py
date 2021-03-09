from datetime import datetime, timedelta
import pandas as pd
from fbprophet import Prophet
import matplotlib.pyplot as plt
plt.style.use('fivethirtyeight')

class Prophet_Prediction:

    def __init__(self, prediction):
        self.collar_id = 'animale_di_prova'

        giorno = datetime.today() + timedelta(days=1) #cioè il giorno dopo
        self.date = str(giorno.year)+ '-' +str(giorno.month)+ '-' + str(giorno.day)

        self.qnt = 30
        self.prediction = prediction


    def to_dict(self):
        dest = {
            u'collar_id': self.collar_id,
            u'quantity': self.qnt,
            u'date': self.date,
            u'predicted_h': self.prediction,
        }
        return dest

