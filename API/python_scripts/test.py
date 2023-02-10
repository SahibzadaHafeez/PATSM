import sys
import os
currentPath = os.path.dirname(os.path.abspath(__file__))
sys.path.append(currentPath + '/modules')
from click import argument
from numpy import true_divide
import twint
import csv
import pandas
import langid
from bs4 import BeautifulSoup
import requests
from requests_html import HTMLSession
import json
import re
import sys
import twint
from selenium import webdriver

def get_twitter_url(usrname):
    return "https://twitter.com/%s/photo" % usrname

def get_avatar_url(usrname):
    url = get_twitter_url(usrname)
    s = HTMLSession()
    r = s.get(url)
    r.html.render(sleep=5)
    print(r.status_code)
    avatar = r.html.find('img.css-9pa8cd')
    print(re.search("(?P<url>https?://[^\s]+)", str(avatar[0])).group("url"))