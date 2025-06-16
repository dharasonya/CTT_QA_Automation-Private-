from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Flask is working!"

if __name__ == "__main__":
    app.run(debug=True, port=8086)  # You can change the port number if needed