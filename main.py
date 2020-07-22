from flask import Flask
import os

# creating and instancec of Flask
app = Flask(__name__)
@app.route("/")
def index():
    return "Hello World!"


print("Hello, world")