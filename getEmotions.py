import indicoio

#Joy, Sadness, Anger, Fear, Surprise

def get_emotions(text, ):
	indicoio.config.api_key = '7b1250a3e26b0a9a5f8f5e424d60e7b4'
	v = indicoio.emotion(text)
	return [v['joy'], v['sadness'],v['anger'],v['fear'],v['surprise']]