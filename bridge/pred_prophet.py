import pandas as pd
from fbprophet import Prophet
import matplotlib.pyplot as plt
from services.db_service import DatabaseService

def fzwait():
    if False:
        return input("Press Enter to continue.")
    return ' '

db_service = DatabaseService()
db_service.initialize_connection()


# 1. lettura dati
coll = db_service.getAllCollection('Prediction')

collar_id = []
dispenser_id = []
quantity = []
date = []
hours = []
tot_date = []
for d in coll:
    curr = d.to_dict()

    data  = str(curr['date_time'].year)+ '-' +str(curr['date_time'].month)+ '-' + str(curr['date_time'].day)
    date.append(data)
    
    tot = str(curr['date_time'].year)+ '-' +str(curr['date_time'].month)+ '-' + str(curr['date_time'].day) +' '+  str(curr['date_time'].hour)+ ':' +str(curr['date_time'].minute)+ ':' + str(curr['date_time'].second)
    tot_date.append(tot)

    hours.append(curr['date_time'].hour)
    collar_id.append(curr['collar_id'])
    dispenser_id.append(curr['dispenserId'])
    quantity.append(curr['quantity'])
    #break
    
print("fuori for")

# 2.0 tipi di dato e nomi colonne
correct_date = pd.DatetimeIndex(date)

d = {'collar_id': collar_id,
 #'dispenser_id': dispenser_id,
  #'quantity': quantity,
   #'date': date,
   'hours': hours,
    'tutto': tot_date
   }
df = pd.DataFrame(data=d)

group = df.rename(columns={'tutto': 'ds',
                        'hours': 'y'})
print(df.head(5))

#3.0 show data
grouped = df.groupby('collar_id')
print(grouped)
for animal in grouped.groups:
    group = grouped.get_group(animal)
    print(group)
    #break
    #ax = df.set_index('ds').plot(figsize=(12, 8))
    #ax.set_ylabel('Monthly Number of Airline Passengers')
    #ax.set_xlabel('Date')
    fig = plt.figure(facecolor='w', figsize=(10, 6))
    plt.plot(group['ds'], group['y'])
    plt.show()
    

    #4.0 model creation
    #my_model = Prophet()


    #5.0 fit the data
    my_model.fit(group.drop(columns=['collar_id']))

    #6.0 creation of future dataframe
    future_dates = my_model.make_future_dataframe(periods=4, freq='day')
    print(future_dates.tail())

    #7.0 forecast
    forecast = my_model.predict(future_dates)
    forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']].tail()

    #8.0 plot of the forecast
    plt2 = my_model.plot(forecast, uncertainty=True)
    plt2.show()
    fzwait()



    plt3 = my_model.plot_components(forecast)
    plt3.show()
    fzwait()

    break

fzwait()