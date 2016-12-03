import os
from watson_developer_cloud import VisualRecognitionV3


API_KEY = os.environ['API_KEY']

CLASSIFIER_MAP = {
    'keys': 'keys_1289660703',
    'card': 'card_1394183405',
    'oreo': 'oreo_6385562',
}

visual_recognition = VisualRecognitionV3('2016-05-20', api_key=API_KEY)


def create_classifier(name):
    """Create a classifier for the specified object."""
    example_path = 'training_data/%s/' % name
    with open(example_path + 'positive.zip', 'rb') as positive_examples:
        with open(example_path + 'negative.zip', 'rb') as negative_examples:
            return visual_recognition.create_classifier(
                name=name,
                object_positive_examples=positive_examples,
                negative_examples=negative_examples,
            )


def classify(image_data, object_class=None, threshold=0.1):
    classifier_ids = [CLASSIFIER_MAP[object_class]] if object_class else None
    return visual_recognition.classify(
        images_file=image_data,
        classifier_ids=classifier_ids,
        threshold=threshold,
    )


def test(filename, object_class=None):
    with open(filename) as f:
        return classify(f, object_class)
