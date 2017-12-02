import sys
import indicoio
import praw

#python subredditTitle pathOfCSV JOY SAD ANGER    -or-
#python subredditTitle pathOfCSV [NOTE ]
if (len(sys.argv) != 4):
	raise "invalid number of arguments. There must be 3, there is %d" %(len(sys.argv)-1)
print sys.argv[1]

reddit = praw.Reddit(user_agent='Comment Extraction (by /u/MaxMB15)',
                     client_id='81NfLOyVODsR7g', client_secret="260X4gdtAeFhtHZZEKVH_r8lKlA",
                     username='MaxMB15', password='tempPass')

#append to the CSV file
import csv

for submission in reddit.subreddit(sys.argv[1]).hot(limit=500):
    print (submission.title)

csvfile = open(sys.argv[2], 'ab')
filewriter = csv.writer(csvfile, quotechar='"', delimiter=',', quoting=csv.QUOTE_ALL, skipinitialspace=True)
for submission in reddit.subreddit(sys.argv[1]).hot(limit=500):
	if submission.title.encode('ascii', 'ignore') != "":
    		filewriter.writerow([submission.title.encode('ascii', 'ignore'), sys.argv[3]])
csvfile.close()
