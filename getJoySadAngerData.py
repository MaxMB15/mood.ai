import sys
import indicoio
import praw

#python subredditTitle pathOfCSV JOY SAD ANGER FEAR SUPRISE    -or-
#python subredditTitle pathOfCSV [NOTE ]

indicoio.config.api_key = '7b1250a3e26b0a9a5f8f5e424d60e7b4'

if (len(sys.argv) != 8 and len(sys.argv) != 3):
	print "invalid number of arguments. There must be 2 or 7, there is ", str(len(sys.argv)-1)
	raise
#print sys.argv[1]

reddit = praw.Reddit(user_agent='Comment Extraction (by /u/MaxMB15)', client_id='81NfLOyVODsR7g', client_secret="260X4gdtAeFhtHZZEKVH_r8lKlA", username='MaxMB15', password='tempPass')

#append to the CSV file
import csv

text_list = []

for submission in reddit.subreddit(sys.argv[1]).hot(limit=1000):
    text = submission.selftext.replace("\n","").replace("*","").encode('ascii', 'ignore')
    if text != None and text != "":
    	text_list.append(text)
    	print text

print len(text_list)

v = indicoio.emotion(text_list)

csvfile = open(sys.argv[2], 'ab')
filewriter = csv.writer(csvfile, quotechar='"', delimiter=',', quoting=csv.QUOTE_ALL, skipinitialspace=True)
if len(sys.argv) == 8:
	joy = sys.argv[3]
	sad = sys.argv[4]
	anger = sys.argv[5]
	fear = sys.argv[6]
	suprise = sys.argv[7]

for i in xrange(len(text_list)):
	xtext = text_list[i]
	if len(sys.argv) == 3:
		xv = v[i]
			
		joy = xv['joy']
		sad = xv['sadness']
		anger = xv['anger']
		fear = xv['fear']
		suprise = xv['suprise']

	filewriter.writerow([xtext, joy, sad, anger, fear, suprise])
csvfile.close()
