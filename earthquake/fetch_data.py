import schedule
import time
import argparse
import datetime
import requests
import pandas as pd
from sqlalchemy import create_engine

def get_data(feature):
    return {
        'id': feature.get('id', None),
        'type': feature.get('type', None),
        'mag': feature.get('properties', {}).get('mag', None),
        'time': feature.get('properties', {}).get('time', None),
        'place': feature.get('properties', {}).get('place', None),
        'geometry_type': feature.get('geometry', {}).get('type', None),
        'longitude': feature.get('geometry', {}).get('coordinates', [None, None, None])[0],
        'latitude': feature.get('geometry', {}).get('coordinates', [None, None, None])[1],
        'depth': feature.get('geometry', {}).get('coordinates', [None, None, None])[2]
    }

def job(db_name, db_table, db_password):
    starttime = (datetime.datetime.now() - datetime.timedelta(days=1)).strftime('%Y-%m-%d')
    endtime = datetime.datetime.now().strftime('%Y-%m-%d')
    # Your extraction code
    url = 'https://earthquake.usgs.gov/fdsnws/event/1/query'
    params = {
        'format': 'geojson',
        'starttime': starttime,
        'endtime': endtime
    }
    response = requests.get(url, params=params)
    data = response.json()
    
    # Your transformation code to get a DataFrame, df
    # df = pd.json_normalize(data['features'])
    df = pd.DataFrame([get_data(feature) for feature in data['features']])
    df = df.dropna()
    df = df[(df.type=="Feature") & (df.geometry_type=="Point")]
    df = df.drop(["type", "geometry_type"], axis=1)

    # Create an SQLAlchemy engine and write your DataFrame into PostgreSQL
    engine = create_engine(f'postgresql://postgres:{db_password}@localhost/{db_name}')
    df.to_sql(db_table, engine, if_exists='replace')
    print(f"{datetime.datetime.now()} : fetching data ... last measure time : {df.time.max()}")


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Scheduled job to query USGS Earthquake API and store data in PostgreSQL')
    parser.add_argument('--frequency', type=int, default=1, help='Frequency of job execution in minutes (e.g., 10min, 1h, 1d)')
    parser.add_argument('--db_name', default="landing_earthquake", 
                        help='db name')
    parser.add_argument('--db_table', default="raw_measures", 
                        help='db table where insertion is done')
    parser.add_argument('--db_password', default="cei5thi1Ahng", 
                        help='postgres db password')
    args = parser.parse_args()

    # Schedule the job based on the specified frequency
    schedule.every(args.frequency).minutes.do(job, args.db_name, args.db_table, args.db_password)

    while True:
        schedule.run_pending()
        time.sleep(10)
