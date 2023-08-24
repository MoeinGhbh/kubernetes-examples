from flask import Flask


app = Flask(__name__)


@app.route("/" , methods=["GET", "POST"] )
def hello_World():
    return "hi man"

if __name__== "__main__":
     app.run( "0.0.0.0" , debug=True)