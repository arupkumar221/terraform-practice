from flask import Flask
from flask import request
from flask import jsonify

app = Flask(__name__)

votes = []

@app.route('/vote', methods=['POST'])
def vote():

    data = request.json
    votes.append(data)

    return jsonify({
        "message":
        f"{data['name']} voted successfully for {data['candidate']}"
    })

@app.route('/results')
def results():
    return jsonify(votes)

app.run(
    host='0.0.0.0',
    port=5000
)