import twint
import csv

with open('dataset/smaller_user_list.csv', 'r') as csv_file:
    csv_reader = csv.reader(csv_file)
    next(csv_reader)


    for row in csv_reader:

        print(row[1])
        config = twint.Config()
        config.Username = row[1]
        config.Lang = "en"
        config.Store_json = True
        config.Output = "dataset/tweet_data.json"

        twint.run.Search(config)
