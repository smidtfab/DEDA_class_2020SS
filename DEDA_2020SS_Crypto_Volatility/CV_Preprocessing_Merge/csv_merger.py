import os
import glob
import pandas as pd
import json

months = ['01', '02', '03', '04', '05', ]#'06', '07', '08', '09', '10', '11', '12']

for month in months:
    regex_pattern = f'data/by_day/*-{month}-*.json' 
    print(regex_pattern)

    glob_data = []

    '''
    see https://stackoverflow.com/a/43413070

    Concat all tweets from different days into one file. Each file consists
    of the following format:
    [{"key1": "value1"}] - (in file1)
    [{"key2": "value2"}] - (in file2)
    '''
    for file in glob.glob(regex_pattern):
        with open(file) as json_file:
            data = json.load(json_file)

            i = 0
            while i < len(data):
                # append row (one tweet)
                glob_data.append(data[i])
                i += 1
    '''
    Dump the consolidated file with the format:
    [{"key1": "value1"},
    {"key2": "value2"}]
    '''
    file_name_month = f'data/by_month/btc_tweets_{month}.json' 
    with open(file_name_month, 'w') as f:
        json.dump(glob_data, f, indent=4)

extension = 'csv'
all_filenames = [i for i in glob.glob('data/by_month/*.{}'.format(extension))]

print(all_filenames)

#combine all files in the list
combined_csv = pd.concat([pd.read_csv(f) for f in all_filenames ])
#export to csv
combined_csv.to_csv("data/combined_tweets.csv", index=False, encoding='utf-8')
