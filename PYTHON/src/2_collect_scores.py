from cgitb import text
import json
import csv
from bs4 import BeautifulSoup
import requests

data = []
with open("dataset/twitter_scrub_result.json", encoding="utf8") as f:
    for line in f:
        data.append(json.loads(line))
    f.close()



for item in data:
    if (len(item["urls"]) > 0):
        if ("https://bigfive-test.com/result/" in item['urls'][0]):
            user_id = item["user_id"]
            username = item['username']
            url = item['urls'][0]
                        
            score_page = requests.get(url)
            doc = BeautifulSoup(score_page.text, "html.parser")
            doc.prettify()

            if "404" in (doc.find("title").get_text()):
                continue
  
            if doc.find("p", {"class": "headline"}):
                continue

            values = doc.find_all("p", {"class": "subheading"})

            neuroticism = int(((values[0].get_text()).split(": ")[1])[0 : 3])
            extraversion = int(((values[7].get_text()).split(": ")[1])[0 : 3])
            openness = int(((values[14].get_text()).split(": ")[1])[0 : 3])
            agreeableness = int(((values[21].get_text()).split(": ")[1])[0 : 3])
            conscientiousness = int(((values[28].get_text()).split(": ")[1])[0 : 3])

            output_list = [user_id, username, neuroticism, extraversion, openness, agreeableness, conscientiousness]

            with open('dataset/scrubbed_personality_users.csv', 'a+', newline='') as csv_file:
                csv_writer = csv.writer(csv_file)
                csv_writer.writerow(output_list)
                print(output_list)

