import os
from watson_developer_cloud import VisualRecognitionV3


API_KEY = os.environ['API_KEY']

visual_recognition = VisualRecognitionV3('2016-05-20', api_key=API_KEY)


def classify(image_data):
    return visual_recognition.classify(images_file=image_data, threshold=0.1)


def test(filename):
    with open(filename) as f:
        return classify(f)
