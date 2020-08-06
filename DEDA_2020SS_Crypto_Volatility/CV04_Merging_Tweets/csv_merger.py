import os
import glob
import pandas as pd
import json
import csv

months = ['01']#, '02', '03', '04', '05', ]#'06', '07', '08', '09', '10', '11', '12']

for month in months:
    regex_pattern = f'../data/Tweets/by_day/*-{month}-*.csv' 
    print(f"regex pat:{regex_pattern}")
    glob_data = []
    # Concat all tweets from different days into one file
    month_filenames = [i for i in glob.glob(regex_pattern)]
    glob_data = pd.concat([pd.read_csv(f, sep=";") for f in month_filenames])
    
    #Dump the consolidated file with the format
    file_name_month = f'../data/Tweets/by_month/btc_tweets_{month}.csv' 
    glob_data.to_csv(file_name_month, index=False, encoding='utf-8')

extension = 'csv'
all_filenames = [i for i in glob.glob('../data/Tweets/by_month/*.{}'.format(extension))]

print(all_filenames)

#combine all files in the list
combined_csv = pd.concat([pd.read_csv(f) for f in all_filenames ])
#export to csv
combined_csv.to_csv("../data/Tweets/combined_tweets.csv", index=False, encoding='utf-8')
