# -*- coding: utf-8 -*-
"""
Created on Sat Dec  2 01:23:34 2017

@author: xingh
"""
import praw
from xh_login_info import *

reddit = praw.Reddit(client_id=xh_client_id,
                     client_secret=xh_client_secret,
                     user_agent=xh_user_agent)

learnpython = [x for x in reddit.subreddit('learnpython').hot(limit=10)]

x = learnpython[0]