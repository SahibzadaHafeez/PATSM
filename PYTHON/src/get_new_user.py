from click import argument
from numpy import true_divide
import twint
import csv
import pandas
import langid
import re
import sys

arg_len = len(sys.argv)
arg = sys.argv

if (arg_len > 1):
    username = arg[1]

pattern = r"http\S+"
#username = "nosebleedplant"
tweets = []
usr = ""

config = twint.Config()
config.Username = username
config.Limit = 1
config.Pandas = True
config.Hide_output = True

twint.run.Search(config)
tweets = twint.storage.panda.Tweets_df



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

if(len(cleaned_tweets) > 15):
    print("OK")