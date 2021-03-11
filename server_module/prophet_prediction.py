from datetime import datetime, timedelta
import pandas as pd
from fbprophet import Prophet
import matplotlib.pyplot as plt
plt.style.use('fivethirtyeight')

class Prophet_Prediction:

    def __init__(self, prediction):
        self.collar_id = 'animale_di_prova'

        self.day = datetime.today() + timedelta(days=1) #cioè il giorno dopo
        self.date = str(self.day.year)+ '-' +str(self.day.month)+ '-' + str(self.day.day)
        self.qnt = 30 #per adesso ci interessa predire solo l'ora e quindi mettiamo una quantità di default.
        self.prediction = prediction


    def to_dict(self):
        dest = {
            u'collar_id': self.collar_id,
            u'quantity': self.qnt,
            u'date': self.date,
            u'predicted_hour': self.prediction,
        }
        return dest

