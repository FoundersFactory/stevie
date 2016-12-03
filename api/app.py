from flask import Flask, jsonify, request, abort
app = Flask(__name__)

magic = 0.0

@app.route('/')
def index():
    return jsonify(hello='world')

@app.route('/find', methods=['POST'])
def find():
    global magic

    item_class = request.args.get('class', None)
    if not item_class:
        return jsonify(error=True, message='Missing class paramater'), 400

    image_data = request.stream.read()
    if len(image_data) < 1:
        return jsonify(error=True, message='Missing image data'), 400

    magic = (magic + 0.1) % 1

    return jsonify(**{ 'score': magic, 'class': item_class })
