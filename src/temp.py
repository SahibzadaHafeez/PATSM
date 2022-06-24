import json
import twint
import os

data =[]
with open("dataset/temp_test.json", encoding="utf8") as f:
    for line in f:
        data.append(json.loads(line))
x = 0
for item in data:
    if (len(item["urls"]) > 0):
        if ("https://bigfive-test.com/result/" in item['urls'][0]):
            print (item["user_id"], item['username'], item['tweet'], item['urls'][0])
            print("---")
