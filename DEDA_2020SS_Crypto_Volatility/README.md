# Crypto Volatility
Scraping of predictors for crypto volatility, visualization and modeling. 

[Link to complete dataset](https://drive.google.com/file/d/12LXOGXLKuEsOxRz89lva5f4ZeIqTCZhI/view?usp=sharing)

## Development Setup

First, clone repo if you haven't already and navigate into project directory e.g. /DEDA_2020SS_Crypto_Volatility:

```bash
$ cd DEDA_2020SS_Crypto_Volatility
```
  
Initialize and activate a conda environment with pip included:
```bash
$ conda create -n yourenv pip
```

Install requirements:
```python
pip install -r requirements.txt
```

## Running the scripts
### Scrape tweets
Specify the start and end date as well as number of tweets per day

```bash
input_start=2020-1-1
input_end=2020-1-2

limit=1000
```

To run

```bash
$ cd CV01_Scraping_Twitter
$ sh CV01_Scraping_Twitter.sh
```

The output will be stored in the ../data/Tweets/by_day folder.

### Scrape trends

Navigate to directory 

```bash
$ cd ../CV02_Scraping_Trends
```

To run 
```python
python3 CV02_Scraping_Trends.py 
```

### Srape market

Navigate to directory 

```bash
$ cd ../CV03_Scraping_Market
```

Specify the key, currency and number of days and run 
```python
python CV03_Scraping_Market.py --s1 BTC --s2 USD --days 80
```

The output will be stored in the ../data/Market folder. Unfortunately, it is only possible to query historical prices for 80 days in the past.

### Merge Tweets
Navigate to directory 

```bash
$ cd ../CV04_Merging_Tweets
```

Specify the months you want to consolidate e.g. months = ['01']. To run
```python
python3 CV04_Merging_Tweets.py
```

All tweets for every corresponding month will be stored in ../data/Tweets/by_month for and all tweets over all specified month in ../data/Tweets/combined_tweets.csv

### Preprocessing 
Navigate to directory 

```bash
$ cd ../CV05_Preprocessing
```

Open CV05_Preprocessing_example.ipynb and run the notebook code with example data. **CV05_Preprocessing.ipynb can only be run with the complete data set, which is not available in the repository due to the file size being to large.** The three components that have been scraped before will be merged and sentiment analysis will be performed. The output will be stored in ../data/btc_final.csv

### EDA 
Navigate to directory 

```bash
$ cd ../CV06_Exploration
```

Run the CV06_Exploration_example.ipynb notebook to explore the data. **CV06_Exploration.ipynb can only be run with the complete data set, which is not available in the repository due to the file size being to large.** Plots will be stored in the same folder.
