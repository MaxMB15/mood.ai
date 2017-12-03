
# coding: utf-8

# In[19]:


from facepy import GraphAPI

# Initialize the Graph API with a valid access token (optional,
# but will allow you to do all sorts of fun stuff).
graph = GraphAPI("EAACEQkPzZBEQBAOaAaKX6JZCsBx3yLJjnXtXR7ZCZAuggxTTAIgXVCutZBEfZBW0ntnIOwHZAtDAZB0rn2eovxlRGeaEkmF50xfxBEzERfRyIamhau2Uv7INgoULMsycZCNTxY3sENe8eDBUVslOTsZBvbWOI6xXuTAi0mTiKalYGQPEf6maP7FUe1Pt6SrdiNHZCGTCIjUbt64c3jeVDkZCxoA3")

# Get my latest posts
posts = graph.get('me/posts')


# In[31]:


posts['paging']['next']


# In[32]:


import requests


# In[63]:


post_limit = 100
x = requests.get(f"https://graph.facebook.com/v2.11/112757542843617/posts?access_token=EAACEQkPzZBEQBAOaAaKX6JZCsBx3yLJjnXtXR7ZCZAuggxTTAIgXVCutZBEfZBW0ntnIOwHZAtDAZB0rn2eovxlRGeaEkmF50xfxBEzERfRyIamhau2Uv7INgoULMsycZCNTxY3sENe8eDBUVslOTsZBvbWOI6xXuTAi0mTiKalYGQPEf6maP7FUe1Pt6SrdiNHZCGTCIjUbt64c3jeVDkZCxoA3&limit={post_limit}&__paging_token=enc_AdCvmOVOK2CWOcoyZBwqxTAOvbSO8cUwCVzWn0YZAlZBjOOFBbbBwYqAAL9VKBa26NctBvgQ9kaJM8bd93bvVoZA71OQN7kbDJKWazLiJbzO36ZB3YAZDZD").json()


# In[98]:


posts = []
months = {
    9:"September",
    10:"October",
    11:"November",
    12:"December"
}

for n in range(len(x['data'])):
    try:
        message = x['data'][n]['message']
        day = n%30 + 1
        month = n//30 + 9
        year = 2017
        date = f"{day:02d}/{month:02d}/{year}"
        posts.append([message,day,month,year,date])
    except:
        pass


# In[99]:


import pandas as pd

df = pd.DataFrame(posts,columns=["message","day","month","year","date"])


# In[100]:


df

