from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles

app = FastAPI()

data_dir = "/Users/jileihao/data/avrspt"

app.mount("/", StaticFiles(directory=data_dir), name="dataFiles")
