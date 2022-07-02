import json
import csv

data = []
with open("dataset/tweet_data.json", encoding="utf8") as f:
    for line in f:
        data.append(json.loads(line))
    f.close()


user_data = []
with open('dataset/user_list.csv', 'r', encoding="utf8") as csv_file:
    csv_reader = csv.reader(csv_file)
    next(csv_reader)
    for row in csv_reader:
        user_data.append(row)



with open('dataset/cleaned_dataset.csv', 'a+', newline='', encoding="utf8") as csv_file:
    csv_writer = csv.writer(csv_file)
    num = 1
    for item in data:
        if (len(item["urls"]) == 0) & (item["language"] == "en"):
            print(num)
            num = num + 1   
            for person in user_data:
                if person[1] == item["username"]:
                    new_line = [item["username"], person[2], person[3], person[4], person[5], person[6], item["tweet"]]

                    csv_writer.writerow(new_line)
                    print(new_line)


