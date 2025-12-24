# backend/config.py

import os

class Config:
    # Clave para sesiones de Flask
    SECRET_KEY = os.environ.get("SECRET_KEY", "cambia-esta-clave")

    # Configuración MySQL
    DB_HOST = os.environ.get("DB_HOST", "localhost")
    DB_USER = os.environ.get("DB_USER", "root")
    DB_PASSWORD = os.environ.get("DB_PASSWORD", "")
    DB_NAME = os.environ.get("DB_NAME", "tienda_tech")


config = Config()
