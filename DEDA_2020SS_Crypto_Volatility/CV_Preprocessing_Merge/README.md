[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **csv_merger** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml


Name of Quantlet: 'csv_merger'

Published in: 'DEDA_Class_2020SS'

Description: 'Creates the csv that will be read into create_final_df. All daily tweets will be aggregated monthly and then concatted into one csv file'

Keywords: 'Tweets, Trends, merge, aggregation, consolidation'

Author: 'Fabian Schmidt'

```

### PYTHON Code
```python

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

```

automatically created on 2020-07-27