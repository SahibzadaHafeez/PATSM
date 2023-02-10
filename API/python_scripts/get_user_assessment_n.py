from ctypes import sizeof
import sys
import os

currentPath = os.path.dirname(os.path.abspath(__file__))
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'
sys.path.append(currentPath + '/modules')

import tensorflow as tf
from keras.models import load_model
import autokeras as ak
import twint
import re
import langid
import numpy as np
import pandas
from requests_html import HTMLSession

import random

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
config.Limit = 20

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

cleaned_tweets = np.array(cleaned_tweets)

values = ["low", "mid", "high", "vhigh"]

loaded_model = load_model((currentPath + '/models/n_model'), custom_objects=ak.CUSTOM_OBJECTS)
n_pred = loaded_model.predict(tf.expand_dims((cleaned_tweets), -1), verbose=0)
n_pred = round(np.average(n_pred))
print(values[n_pred])

loaded_model = load_model((currentPath + '/models/e_model'), custom_objects=ak.CUSTOM_OBJECTS)
e_pred = loaded_model.predict(tf.expand_dims((cleaned_tweets), -1), verbose=0)
e_pred = round(np.average(e_pred))
print(values[e_pred])

loaded_model = load_model((currentPath + '/models/o_model'), custom_objects=ak.CUSTOM_OBJECTS)
o_pred = loaded_model.predict(tf.expand_dims((cleaned_tweets), -1), verbose=0)
o_pred = round(np.average(o_pred))
print(values[o_pred])

loaded_model = load_model((currentPath + '/models/a_model'), custom_objects=ak.CUSTOM_OBJECTS)
a_pred = loaded_model.predict(tf.expand_dims((cleaned_tweets), -1), verbose=0)
a_pred = round(np.average(a_pred))
print(values[a_pred])

loaded_model = load_model((currentPath + '/models/c_model'), custom_objects=ak.CUSTOM_OBJECTS)
c_pred = loaded_model.predict(tf.expand_dims((cleaned_tweets), -1), verbose=0)
c_pred = round(np.average(c_pred))
print(values[c_pred])

def random_score(val):
    if val == 0:
        print(random.randint(20, 30))
    elif val == 1:
        print(random.randint(30, 60))
    elif val == 3:
        print(random.randint(60, 85))
    else:
        print(random.randint(85, 120))

def get_twitter_url(usrname):
    return "https://twitter.com/%s/photo" % usrname

def get_avatar_url(usrname):
    url = get_twitter_url(usrname)
    s = HTMLSession()
    r = s.get(url)
    r.html.render(sleep=5)
    avatar = r.html.find('img.css-9pa8cd')
    return (re.search("(?P<url>https?://[^\s]+)", str(avatar[0])).group("url"))[:-1]

loaded_model = load_model((currentPath + '/models/n_model_r'), custom_objects=ak.CUSTOM_OBJECTS)
n_pred = loaded_model.predict(tf.expand_dims((cleaned_tweets), -1), verbose=0)
n_pred = round(np.average(n_pred))
print(n_pred)

loaded_model = load_model((currentPath + '/models/e_model_r'), custom_objects=ak.CUSTOM_OBJECTS)
e_pred = loaded_model.predict(tf.expand_dims((cleaned_tweets), -1), verbose=0)
e_pred = round(np.average(e_pred))
print(e_pred)

loaded_model = load_model((currentPath + '/models/o_model_r'), custom_objects=ak.CUSTOM_OBJECTS)
o_pred = loaded_model.predict(tf.expand_dims((cleaned_tweets), -1), verbose=0)
o_pred = round(np.average(o_pred))
print(o_pred)

loaded_model = load_model((currentPath + '/models/a_model_r'), custom_objects=ak.CUSTOM_OBJECTS)
a_pred = loaded_model.predict(tf.expand_dims((cleaned_tweets), -1), verbose=0)
a_pred = round(np.average(a_pred))
print(a_pred)

loaded_model = load_model((currentPath + '/models/c_model_r'), custom_objects=ak.CUSTOM_OBJECTS)
c_pred = loaded_model.predict(tf.expand_dims((cleaned_tweets), -1), verbose=0)
c_pred = round(np.average(c_pred))
print(c_pred)




# random_score(n_pred)
# random_score(e_pred)
# random_score(o_pred)
# random_score(a_pred)
# random_score(c_pred)

print(username)
print(tweets['user_id'].iloc[0])
#print(get_avatar_url(username))