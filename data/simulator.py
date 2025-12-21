from sqlalchemy import create_engine
import psycopg2
import pandas
import random
import time

engine = create_engine("postgresql+psycopg2://postgres:System2024@localhost:5432/postgres")
