from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return {"Message":"Hello World!"}