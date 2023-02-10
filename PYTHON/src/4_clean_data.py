import json
import csv
import re
import langid
import pandas

pattern = r"http\S+"

data = []
with open("dataset/scraped_user_tweets.json", encoding="utf8") as f:
    for line in f:
        data.append(json.loads(line))
    f.close()


user_data = []
with open('dataset/scrubbed_personality_users.csv', 'r', encoding="utf8") as csv_file:
    csv_reader = csv.reader(csv_file)
    next(csv_reader)
    for row in csv_reader:
        user_data.append(row)


with open('dataset/temp_cleaned_data.csv', 'a+', newline='', encoding="utf8") as csv_file:
    csv_writer = csv.writer(csv_file)
    num = 1
    for item in data:
        item["tweet"] = re.sub(pattern, "", item["tweet"])
        temp_tweet = item["tweet"]
        temp_tweet = temp_tweet.lower()
        try:
            lang_det = (langid.classify(item["tweet"])[0])
            print (lang_det)
        except:
            lang_det = "x"
        item["tweet"] = " ".join(filter(lambda x:x[0]!='@', temp_tweet.split()))
        item["tweet"] = re.sub('[^a-zA-Z]', " ", item["tweet"])
        temp_tweet = item["tweet"]
        item["tweet"] = " ".join(temp_tweet.split())
        
        if ( lang_det == "en"):
            print(num)
            num = num + 1   
            for person in user_data:
                if (person[1] == item["username"]) & (len(item["tweet"]) > 20):
                    new_line = [item["username"], person[2], person[3], person[4], person[5], person[6], item["tweet"], (langid.classify(item["tweet"])[0]), len(item["tweet"])]

                    csv_writer.writerow(new_line)
                    print(new_line)

cleaned_data = pandas.read_csv('dataset/temp_cleaned_data.csv')

print(len(cleaned_data.index))
cleaned_data.drop_duplicates(subset=['tweet'], keep='first', inplace = True)
print(len(cleaned_data.index))

cleaned_data.to_csv("dataset/final_cleaned_data.csv", encoding='utf-8')

# cleaned_data = pandas.read_csv('dataset/final_cleaned_data.csv')
for index, row in cleaned_data.iterrows():
    if (row['neuroticism'] <= 30):
        cleaned_data.at[index,'neuroticism'] = 0
    elif (row['neuroticism'] <= 60):
        cleaned_data.at[index,'neuroticism'] = 1
    elif (row['neuroticism'] <= 85):
        cleaned_data.at[index,'neuroticism'] = 2
    elif (row['neuroticism'] > 85):
        cleaned_data.at[index,'neuroticism'] = 3

    if (row['extraversion'] <= 30):
        cleaned_data.at[index,'extraversion'] = 0
    elif (row['extraversion'] <= 60):
        cleaned_data.at[index,'extraversion'] = 1
    elif (row['extraversion'] <= 85):
        cleaned_data.at[index,'extraversion'] = 2
    elif (row['extraversion'] > 85):
        cleaned_data.at[index,'extraversion'] = 3

    if (row['openness'] <= 30):
        cleaned_data.at[index,'openness'] = 0
    elif (row['openness'] <= 60):
        cleaned_data.at[index,'openness'] = 1
    elif (row['openness'] <= 85):
        cleaned_data.at[index,'openness'] = 2
    elif (row['openness'] > 85):
        cleaned_data.at[index,'openness'] = 3

    if (row['agreeableness'] <= 30):
        cleaned_data.at[index,'agreeableness'] = 0
    elif (row['agreeableness'] <= 60):
        cleaned_data.at[index,'agreeableness'] = 1
    elif (row['agreeableness'] <= 85):
        cleaned_data.at[index,'agreeableness'] = 2
    elif (row['agreeableness'] > 85):
        cleaned_data.at[index,'agreeableness'] = 3

    if (row['conscientiousness'] <= 30):
        cleaned_data.at[index,'conscientiousness'] = 0
    elif (row['conscientiousness'] <= 60):
        cleaned_data.at[index,'conscientiousness'] = 1
    elif (row['conscientiousness'] <= 85):
        cleaned_data.at[index,'conscientiousness'] = 2
    elif (row['conscientiousness'] > 85):
        cleaned_data.at[index,'conscientiousness'] = 3

cleaned_data.to_csv("dataset/classified_cleaned_data.csv", encoding='utf-8')
