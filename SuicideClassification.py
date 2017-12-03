# System Imports
import six
import sys
# Imports the Google Cloud and Indico.io client library
from google.cloud import language
from google.cloud.language import enums
from google.cloud.language import types
import indicoio
# Import ML libraries
import pandas as pd
import numpy as np
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import AdaBoostClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.externals import joblib
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import train_test_split, cross_val_score
# Credentials
from xh_login_info import *
import json


from flask import Flask


# Instantiates a client
client = language.LanguageServiceClient()
indicoio.config.api_key = max_indicoio_apikey


# Function definition
def sentiment_text(text):
    """Detects sentiment in the text."""
    client = language.LanguageServiceClient()

    if isinstance(text, six.binary_type):
        text = text.decode('utf-8')

    # Instantiates a plain text document.
    document = types.Document(
        content=text,
        type=enums.Document.Type.PLAIN_TEXT)

    # Detects sentiment in the document. You can also analyze HTML with:
    #   document.type == enums.Document.Type.HTML
    sentiment = client.analyze_sentiment(document).document_sentiment

    return [sentiment.score, sentiment.magnitude]


def get_entity_sentiment(text):
    client = language.LanguageServiceClient()

    if isinstance(text, six.binary_type):
        text = text.decode('utf-8')

    document = types.Document(
            content=text.encode('utf-8'),
            type=enums.Document.Type.PLAIN_TEXT)

    # Detect and send native Python encoding to receive correct word offsets.
    encoding = enums.EncodingType.UTF32
    if sys.maxunicode == 65535:
        encoding = enums.EncodingType.UTF16

    result = client.analyze_entity_sentiment(document, encoding)

    salience_ls = [[] for x in range(8)]
    score_ls = [[] for x in range(8)]
    magnitude_ls = [[] for x in range(8)]

    for entity in result.entities:
        salience_ls[entity.type].append(entity.salience)
        score_ls[entity.type].append(entity.sentiment.score)
        magnitude_ls[entity.type].append(entity.sentiment.magnitude)

    mean_salience_ls = [sum(x)/len(x) if x else 0 for x in salience_ls]
    mean_score_ls = [sum(x)/len(x) if x else 0 for x in score_ls]
    mean_magnitude_ls = [sum(x)/len(x) if x else 0 for x in score_ls]

    all_ls = mean_salience_ls + mean_score_ls + mean_magnitude_ls
    return all_ls


def get_emotions(text):
    v = indicoio.emotion(text)
    return [v['joy'], v['sadness'], v['anger'], v['fear'], v['surprise']]


def text2data(text):
    return np.array(sentiment_text(text) + get_entity_sentiment(text) + get_emotions(text)).reshape(1, -1)


def text2risk(text):
    regr = joblib.load("regr.pkl")
    return str(regr.predict(text2data(text))[0])


app = Flask(__name__)

@app.route('/<inputText>')
def homepage(inputText):
    return text2risk(inputText)


if __name__ == "__main__":
    example_text = """
    I'm 25, college grad, engineer, fiancee, 50k savings.I hate it all. Our life is just a constant grind. Work your ass off in school so you can go to "good" college. Work your ass off in college so you can find "good" job. Find a job and grind your life away there (and half of my friends are unemployed and with technical degrees, so pointless effort). All this effort is supposed to make you happy. It didnt work out for me, I never considered graduating and having a "career" a success.I am amazed how most of people can enjoy simple things (video games, football) without feeling that this world is a downward spiral.Am I depressed? What do I do?
    """
    text_data = text2data(example_text)
    print(text_data)

    b_dtc = joblib.load("boosted_dtc.pkl")

    print(b_dtc)
