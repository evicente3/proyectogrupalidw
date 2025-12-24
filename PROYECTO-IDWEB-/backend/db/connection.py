# backend/db/connection.py
import mysql.connector
from mysql.connector import Error
from config import config

def get_connection():
    return mysql.connector.connect(
        host=config.DB_HOST,
        user=config.DB_USER,
        password=config.DB_PASSWORD,
        database=config.DB_NAME,
    )
