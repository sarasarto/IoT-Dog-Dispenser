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

d = {'collar_id': collar_id, 'dispenser_id': dispenser_id, 'quantity': quantity, 'date': date, 'hours': hours, 'tutto': tot_date}
df = pd.DataFrame(data=d)

df = df.rename(columns={'date': 'ds',
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

    #plt.show()
    break

#fzwait()