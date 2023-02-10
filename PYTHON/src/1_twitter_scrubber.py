import twint
import csv



config = twint.Config()
config.Lang = "en"
config.Search = "bigfive-test.com/result/"
config.Store_json = True
config.Output = "dataset/twitter_scrub_result.json"

twint.run.Search(config)
