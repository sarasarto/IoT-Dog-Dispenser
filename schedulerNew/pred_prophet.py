import pandas as pd
from fbprophet import Prophet
import matplotlib.pyplot as plt
from db_scheduler import DatabaseService
plt.style.use('fivethirtyeight')

def fzwait():
    if False:
        return input("Press Enter to continue.")
    return ' '

db_service = DatabaseService()
db_service.initialize_connection()


# 1. lettura dati
coll = db_service.getAllCollection('Prediction')
df = pd.read_csv('schedulerNew/date_hours.csv')
print(df.head(5))

#collar_id = []
#date = []
#hours = []
#tot_date = []
for d in coll:
    break
    curr = d.to_dict()

    data  = str(curr['date_time'].year)+ '-' +str(curr['date_time'].month)+ '-' + str(curr['date_time'].day)
    date.append(data)
    
    tot = str(curr['date_time'].year)+ '-' +str(curr['date_time'].month)+ '-' + str(curr['date_time'].day) +' '+  str(curr['date_time'].hour)+ ':' +str(curr['date_time'].minute)+ ':' + str(curr['date_time'].second)
    tot_date.append(tot)

    hours.append(curr['date_time'].hour)
    collar_id.append(curr['collar_id'])
    #break
    
print("fuori for") 

# 2.0 tipi di dato e nomi colonne
correct_date = pd.DatetimeIndex(date)

d = {'collar_id': collar_id,
 #'dispenser_id': dispenser_id,
  #'quantity': quantity,
   'date': date,
   'hours': hours,
   # 'tutto': tot_date
   }
df = pd.DataFrame(data=d)

df = df.rename(columns={'date': 'ds',
                        'hours': 'y'})
print(df.head(5)) 
print(df.dtypes)
df['Date'] = pd.DatetimeIndex(df['Date'])
print(df.dtypes)
df = df.rename(columns={'Date': 'ds',
                        'Hours': 'y'})
print(df.head(5))


#3.0 show data
grouped = df.groupby('collar_id')
print(grouped)
for animal in grouped.groups:
    group = grouped.get_group(animal)
   
    #break
    #ax = df.set_index('ds').plot(figsize=(12, 8))
    #ax.set_ylabel('Monthly Number of Airline Passengers')
    #ax.set_xlabel('Date')
    fig = plt.figure(facecolor='w', figsize=(10, 6))
    plt.plot(group['ds'], group['y'])
    plt.show()
    print(group)
    group = group.drop(columns=['collar_id'])
    print('quaaaa')
    print(group)
    
    break
    #4.0 model creation
    my_model = Prophet()


    #5.0 fit the data
    my_model.fit(group)

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

#3.0 show data
ax = df.set_index('ds').plot(figsize=(12, 8))
ax.set_ylabel('Erogation hour')
ax.set_xlabel('Date')

plt.show()

fzwait()
