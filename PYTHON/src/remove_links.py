import re
import csv

pattern = r"http\S+"

user_data = []
with open('dataset/cleaned_dataset.csv', 'r', encoding="utf8") as csv_file:
    csv_reader = csv.reader(csv_file)
    next(csv_reader)
    for row in csv_reader:
        user_data.append(row)

# for item in user_data:
#     print(item[6])

with open('dataset/cleaner_dataset.csv', 'a+', newline='', encoding="utf8") as csv_file:
    csv_writer = csv.writer(csv_file)
    for item in user_data:
        item[6] = re.sub(pattern, "", item[6])
        csv_writer.writerow(item)
        print(item)