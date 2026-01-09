import sqlalchemy as db
import pandas as pd
import random
from datetime import datetime, timedelta    

def generate_reading(start_time: datetime) -> dict:
    '''
    Generate random values to feed the project database and classify the process status
    '''
    hour = start_time.hour
    now = start_time

    if 6 <= hour < 14:
        operator = 1
    elif 14 <= hour < 22:
        operator = 2
    else:   
        operator = 3

    temperature = round(random.gauss(70, 6), 2)
    vibration = round(abs(random.gauss(3.0, 0.8)),2 )
    pressure = round(random.gauss(110, 8), 2)
    cycletime = round(random.gauss(40, 2.5), 2)

    if temperature > 85 or vibration > 4.8 or pressure < 90 or cycletime > 45:
        status = 1
    else:
        status = 0

    return {
        "id_operator": operator,
        "current_time_register": now,
        "temperature_c": temperature,
        "vibration_rms": vibration,
        "hidraulic_pressure": pressure,
        "cycletime_s": cycletime,
        "quality_status": status
    } 

engine = db.create_engine("postgresql+psycopg2://postgres:System2024@localhost:5432/postgres")

parts_per_shift = 300000  # Set how many sample parts will be collected per shift (300.000 parts generates a semester cumulated historic)

shifts = [
    {"id": 1, "start": 6},
    {"id": 2, "start": 14},
    {"id": 3, "start": 22}
]
current_date = datetime(2025, 1, 1)

# Runs the sample generation per shift and inserts them in the database
for shift in shifts:
    current_time = current_date.replace(hour=shift['start'], minute=0, second=0)
    current_package = []
    count = 0
    while count <= parts_per_shift:
        data_generator = generate_reading(current_time)
        data_generator["id_operator"] = shift['id']
        current_package.append(data_generator)
        current_time += timedelta(seconds=(data_generator["cycletime_s"] + 5))
        df_pack = pd.DataFrame(current_package)
        oficial_columns = ["id_operator", "current_time_register", "temperature_c", "vibration_rms", "hidraulic_pressure", "cycletime_s", "quality_status"]
        df_pack[oficial_columns].to_sql('sensor_data', engine, if_exists='append', index=False, method='multi')
        current_package.clear()
        del df_pack
        count += 1   