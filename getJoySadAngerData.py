import sys
import indicoio
import praw

#python subredditTitle pathOfCSV JOY SAD ANGER    -or-
#python subredditTitle pathOfCSV [NOTE ]

indicoio.config.api_key = '7b1250a3e26b0a9a5f8f5e424d60e7b4'

if (len(sys.argv) != 6 and len(sys.argv) != 3):
	print "invalid number of arguments. There must be 2 or 5, there is ", str(len(sys.argv)-1)
	raise
#print sys.argv[1]

reddit = praw.Reddit(user_agent='Comment Extraction (by /u/MaxMB15)', client_id='81NfLOyVODsR7g', client_secret="260X4gdtAeFhtHZZEKVH_r8lKlA", username='MaxMB15', password='tempPass')

#append to the CSV file
import csv

for submission in reddit.subreddit(sys.argv[1]).hot(limit=20):
    print (submission.title)

csvfile = open(sys.argv[2], 'ab')
filewriter = csv.writer(csvfile, quotechar='"', delimiter=',', quoting=csv.QUOTE_ALL, skipinitialspace=True)
if len(sys.argv) == 6:
	joy = sys.argv[3]
	sad = sys.argv[4]
	anger = sys.argv[5]

for submission in reddit.subreddit(sys.argv[1]).hot(limit=20):
	text = submission.selftext.replace("\n","").replace("*","")
	
	if (text != None) and (submission.title.encode('ascii', 'ignore') != "") and (text != ""):
		if len(sys.argv) == 3:
			print text
			v = indicoio.emotion(text)
			print v
			joy = v['joy']
			sad = v['sadness']
			anger = v['anger']

		filewriter.writerow([text.encode('ascii', 'ignore'), joy, sad, anger])
csvfile.close()
