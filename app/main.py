# app/main.py

from fastapi import FastAPI

posts = [
    {
        "title":"Moby Dick",
        "author":"Charles Dickens"
    }
]
app = FastAPI(title="FastAPI, Docker")


@app.get("/")
def read_root():
    return {"Message": "La concha de tu madre por fin funciono la dockerizacion"}

@app.get("/Posts")
def read_posts():
    return posts