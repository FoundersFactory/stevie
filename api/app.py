from flask import Flask, jsonify, request
from StringIO import StringIO
from watson import classify, CLASSIFIER_MAP


app = Flask(__name__)


@app.route('/')
def index():
    return jsonify(hello='world')


@app.route('/class_list')
def class_list():
    return jsonify(class_list=CLASSIFIER_MAP.keys())


@app.route('/find', methods=['POST'])
def find():
    object_class = request.args.get('class', None)
    if not object_class:
        return jsonify(error=True, message='Missing class paramater'), 400

    image_data = request.stream.read()
    if len(image_data) < 1:
        return jsonify(error=True, message='Missing image data'), 400
    else:
        image_data = StringIO(image_data)
        # Force jpeg - Watson API needs name to map mimetype:
        image_data.name = 'temp.jpg'

    try:
        result = classify(image_data, object_class=object_class)
    except AttributeError:
        return jsonify(error=True, message='Invalid image data?'), 400
    else:
        try:
            # There's only one image sent and only one classifier specified,
            # so checking index 0 should be safe here:
            classifiers = result['images'][0]['classifiers']
            score = classifiers[0]['classes'][0]['score']
        except IndexError:
            # The classifier didn't match
            score = 0.0

    return jsonify(**{'score': score, 'class': object_class})
