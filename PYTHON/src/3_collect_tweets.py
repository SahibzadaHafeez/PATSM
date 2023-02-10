import twint
import csv

with open('dataset/scrubbed_personality_users.csv', 'r') as csv_file:
    csv_reader = csv.reader(csv_file)
    next(csv_reader)

    count = 0

    for row in csv_reader:

        print(row[1])
        config = twint.Config()
        config.User_id = row[0]
        config.Lang = "en"
        config.Limit = 100
        config.Store_json = True
        config.Output = "dataset/scraped_user_tweets.json"

        try:
            twint.run.Search(config)
        except:
            count = count + 1
            print("id not found")

print("no of Ids not found: ", count)