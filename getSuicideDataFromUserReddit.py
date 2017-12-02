import sys

import praw

#python subredditTitle pathOfCSV
if (len(sys.argv) != 3):
	raise "invalid number of arguments. There must be 2, there is %d" %(len(sys.argv)-1)
print sys.argv[1]

reddit = praw.Reddit(user_agent='Comment Extraction (by /u/MaxMB15)',
                     client_id='81NfLOyVODsR7g', client_secret="260X4gdtAeFhtHZZEKVH_r8lKlA",
                     username='MaxMB15', password='tempPass')

subreddit = reddit.subreddit('depression_help')

for submission in reddit.subreddit('depression_help').hot(limit=200):
    print(submission.title)













