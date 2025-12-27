import sqlalchemy as db
import pandas as pd
import random

def generate_reading() -> dict:
    '''
    Generate random values to feed the project database and classify the process status
    '''
    temperature = random.uniform(60, 100)
    vibration = random.uniform(0.5, 5.0)
    pressure = random.uniform(70.0, 130.0)
    cycletime = random.uniform(35.0, 50.0)
    operator = random.randint(1, 3)

    if temperature > 85 or vibration > 4.8 or pressure < 90 or cycletime > 45:
        status = 1
    else:
        status = 0

    return {
        "id_operator": operator,
        "temperature_c": temperature,
        "vibration_rms": vibration,
        "hidraulic_pressure": pressure,
        "cycletime_s": cycletime,
        "quality_status": status
    }        
    
engine = db.create_engine("postgresql+psycopg2://postgres:System2024@localhost:5432/postgres")

entry_sample = []

for i in range(1,500000):
    data_generator = generate_reading()
    entry_sample.append(data_generator)

query = pd.DataFrame(entry_sample)
query.to_sql('sensor_data', engine, if_exists='append', index=False, chunksize=10000, method='multi')