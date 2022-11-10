import configparser
from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.cors import CORSMiddleware


app = FastAPI()


origins = ["*"]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# read data dir from config
config = configparser.ConfigParser()
config.read("../config.ini")
data_dir = config["GENERAL"]["DataDirectory"]

print(f"Serving data from directory: {data_dir}")

app.mount("/", StaticFiles(directory=data_dir), name="dataFiles")
