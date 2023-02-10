import sys
import os
currentPath = os.path.dirname(os.path.abspath(__file__))
sys.path.append(currentPath + '/modules')

from requests_html import HTMLSession

from click import argument
from numpy import true_divide
import twint
import csv
import pandas
import langid
import bs4
import requests
import re

def get_twitter_url(usrname):
    return "https://twitter.com/%s/photo" % usrname

def get_avatar_url(usrname):
    url = get_twitter_url(usrname)
    s = HTMLSession()
    r = s.get(url)
    r.html.render(sleep=5)
    avatar = r.html.find('img.css-9pa8cd')
    return (re.search("(?P<url>https?://[^\s]+)", str(avatar[0])).group("url"))[:-1]

arg_len = len(sys.argv)
arg = sys.argv

if (arg_len > 1):
    username = arg[1]

pattern = r"http\S+"
#username = "nosebleedplant"
tweets = []
config = twint.Config()
config.Username = username
config.Pandas = True
config.Hide_output = True
try:
    twint.run.Search(config)
    tweets = twint.storage.panda.Tweets_df
except:
    print('notfound')
    exit(100)

cleaned_tweets = []

for tweet in tweets["tweet"]:
    tweet = re.sub(pattern, "", tweet)
    temp_tweet = tweet
    temp_tweet = temp_tweet.lower()
    try:
        lang_det = (langid.classify(tweet)[0])
    except:
        lang_det = "x"
    tweet = " ".join(filter(lambda x:x[0]!='@', temp_tweet.split()))
    tweet = re.sub('[^a-zA-Z]', " ", tweet)
    temp_tweet = tweet
    tweet = " ".join(temp_tweet.split())
    
    
    if ( lang_det == "en") & (len(tweet) > 20):
        cleaned_tweets.append(tweet)

#print(cleaned_tweets)
if(len(cleaned_tweets) > 15):
    print("ok")
    print(username)
    print(tweets['user_id'].iloc[0])
    print(get_avatar_url(username))
else:
    print("fail")
    print(username)
    print(tweets['user_id'].iloc[0])
    print(get_avatar_url(username))
    