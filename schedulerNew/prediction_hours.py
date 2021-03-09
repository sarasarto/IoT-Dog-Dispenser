import pandas as pd
from fbprophet import Prophet
import matplotlib.pyplot as plt
plt.style.use('fivethirtyeight')

class Hour_Prediction:
    def __init__(self, file_name):
        self.file_name = file_name

    def do_pred(self):
        # 1. lettura dati
        print("sto leggendo dal csv")
        df = pd.read_csv(self.file_name)
        #print(df.head(5))

        df['Date'] = pd.DatetimeIndex(df['Date'])
        df = df.rename(columns={'Date': 'ds',
                                'Hours': 'y'})

        # 4.0 model creation
        my_model = Prophet(interval_width=0.95, daily_seasonality=True)
        # 5.0 fit the data
        my_model.fit(df)

        # 6.0 creation of future dataframe
        future_dates = my_model.make_future_dataframe(periods=1, freq='D')

        forecast = my_model.predict(future_dates)
        forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']].tail()

        return round(forecast['yhat'][1])

