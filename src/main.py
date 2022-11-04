from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
import configparser

app = FastAPI()

# read data dir from config
config = configparser.ConfigParser()
config.read("../config.ini")
data_dir = config["GENERAL"]["DataDirectory"]

print(f"Serving data from directory: {data_dir}")

app.mount("/", StaticFiles(directory=data_dir), name="dataFiles")
