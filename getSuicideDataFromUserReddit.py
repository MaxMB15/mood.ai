import sys

import praw

#python subredditTitle pathOfCSV riskOfSuisideNumber
if (len(sys.argv) != 4):
	print 'Invalid number of arguments. There must be 3, there is ', str(len(sys.argv)-1)
	raise ()
print sys.argv[1]

reddit = praw.Reddit(user_agent='Comment Extraction (by /u/MaxMB15)',
                     client_id='81NfLOyVODsR7g', client_secret="260X4gdtAeFhtHZZEKVH_r8lKlA",
                     username='MaxMB15', password='tempPass')

#append to the CSV file
import csv

for submission in reddit.subreddit(sys.argv[1]).hot(limit=1000):
    print (submission.selftext.replace("\n","").replace("*",""))

csvfile = open(sys.argv[2], 'ab')
filewriter = csv.writer(csvfile, quotechar='"', delimiter=',', quoting=csv.QUOTE_ALL, skipinitialspace=True)
for submission in reddit.subreddit(sys.argv[1]).hot(limit=1000):
	if (submission.selftext.replace("\n","").replace("*","") != None) and (submission.title.encode('ascii', 'ignore') != "") and (submission.selftext.replace("\n","").replace("*","") != ""):
    		filewriter.writerow([submission.selftext.replace("\n","").replace("*","").encode('ascii', 'ignore'), sys.argv[3]])
csvfile.close()
