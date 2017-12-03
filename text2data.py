# System Imports
import sys, six
# Imports the Google Cloud and Indico.io client library
from google.cloud import language
from google.cloud.language import enums
from google.cloud.language import types
import indicoio
# Import ML libraries
import pandas as pd
import numpy as np
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import AdaBoostClassifier
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import train_test_split, cross_val_score
# Credentials
from xh_login_info import *


# Instantiates a client
client = language.LanguageServiceClient()


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
    indicoio.config.api_key = '7b1250a3e26b0a9a5f8f5e424d60e7b4'
    v = indicoio.emotion(text)
    return [v['joy'], v['sadness'], v['anger'], v['fear'], v['surprise']]


indicoio.config.api_key = max_indicoio_apikey

# Joy, Sadness, Anger, Fear, Surprise



