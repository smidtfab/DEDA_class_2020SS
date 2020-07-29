#Codes for Streaming (And Tokenizing)

import matplotlib.pyplot as plt
import sys, tweepy 
import tweepy
from textblob import TextBlob
from tweepy import Stream
from tweepy.streaming import StreamListener


consumer_key = 'BBZeThNQwTZeeU6XLFXbbmmLZ'
consumer_secret = 'kxu1E4KUXkNz1oR6mi2bYKwlFcfopf5He30K4HbEFkXOcz2UHx'
access_token = '68661174-tkh4whbiRPcmjX4wZjfvz3yproYCM9Mwe7OHUBaAN'
access_token_secret = 'RhPOUF44qyFrOWboEZ4fLZUEDI76OGAUxwrWiBFpF1XCX'
auth = tweepy.OAuthHandler(consumer_key,consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth)
public_tweets = api.search('Cryptocurrency')
for tweet in public_tweets:
    print(tweet.text)
    analysis = TextBlob(tweet.text)
    print(analysis.sentiment)


#Codes for saving Table

consumer_key= 'BBZeThNQwTZeeU6XLFXbbmmLZ'
consumer_secret='kxu1E4KUXkNz1oR6mi2bYKwlFcfopf5He30K4HbEFkXOcz2UHx'
access_token='68661174-tkh4whbiRPcmjX4wZjfvz3yproYCM9Mwe7OHUBaAN'
access_token_secret='RhPOUF44qyFrOWboEZ4fLZUEDI76OGAUxwrWiBFpF1XCX'
auth=tweepy.OAuthHandler(consumer_key,consumer_secret)
auth.set_access_token(access_token,access_token_secret)
api=tweepy.API(auth)
public_tweets=api.search('Cryptocurrency')
for tweet in public_tweets:
    print(tweet.text)
    analysis=TextBlob(tweet.text)
    print(analysis.sentiment)

class listener(StreamListener):

    def on_data(self,data):
         try:            
            tweet = data.split(',"text":"')[1].split('","source')[0]
            print (tweet)

            saveThis =tweet
            saveFile = open('twitDB5.csv','a')
            saveFile.write(saveThis)
            saveFile.write('\n')
            saveFile.close()
            return True
         except BaseException as e:
            print ("Error on_data %s" % str(e))
            time.sleep(5)
    def on_error(self, status):
        print (status)
auth=tweepy.OAuthHandler(consumer_key,consumer_secret)
auth.set_access_token(access_token,access_token_secret)

twitterStream=Stream(auth,listener())
twitterStream.filter(track=['Cryptocurrency'])


#Codes for Crearing a Table

from prettytable import PrettyTable
from prettytable import from_csv
import  pandas as pd
import xlsxwriter
df = pd.read_csv('twitDB4.csv', sep='delimiter', header=None, engine='python')
print (df)
pd.DataFrame.to_excel(writer,sheet_name=jhingur,index=False)
writer = pd.ExcelWriter


#Codes for Creating a Wordcloud

from wordcloud import WordCloud
import matplotlib.pyplot as plt
from PIL import Image
import numpy as np
f= "cryptocurrency Investment bitcoin technology advancement banking sector million billion dollars USA Crix Innovative Vision Stablecoins Money Dynamic Startup Offering Commission Airdrop Undervalued Wave Spiking Dropped decline etheriums strong anticipate altcoins centralbank payment phorecrypto hacking congestion exodus truncated ban Businnesses excahnge Trader stratergies profiting Investing"
mask = np.array(Image.open('Snip.png'))
wordcloud = WordCloud(width = 100, height = 100,
                    background_color = 'white',
                    min_font_size = 1,mask = mask).generate(f)

wordcloud.to_file('Image.png')

print ('Image.png')

plt.imshow(wordcloud)
plt.axis('off')
plt.show()


#Code for Bar graph

import sys,tweepy
import matplotlib.pyplot as plt
import nltk
labels=['neutral', 'positive', 'negative']
values=[74,20,6]
plt.bar(labels,values)
plt.title('Sentiments classified into Bar-Graph')


#Streaming Tweets and cleaning 

import os
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import itertools
import collections

import tweepy as tw
import nltk
from nltk.corpus import stopwords
import re
import networkx

import warnings
warnings.filterwarnings("ignore")

sns.set(font_scale=1.5)
sns.set_style("whitegrid")

consumer_key= ‘’
consumer_secret='’'
access_token='’
access_token_secret='’

auth = tw.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tw.API(auth, wait_on_rate_limit=True)

search_term = "#cryptocurrency -filter:retweets"

tweets = tw.Cursor(api.search,
                   q=search_term,
                   lang="en",
                   since='2020-05-21').items(1000)

all_tweets = [tweet.text for tweet in tweets]

all_tweets[:60]



#Code for Tokenization

word_list = ["cryptocurrency", "investment", "bitcoin", "technology", "cat", "advancement", "banking", "million", "sector", "dollar", "USA", "innovative", "vision", "stable", "coins", "money"]
lower_case = [word.lower() for word in word_list]

all_tweets_no_urls[0].split()

words_in_tweet = [tweet.lower().split() for tweet in all_tweets]
words_in_tweet[:2]



#Codes for top 50 Tweets (Cleaned Tweets)


def remove_url(txt):
     return " ".join(re.sub("([^0-9A-Za-z \t])|(\w+:\/\/\S+)", "", txt).split())
all_tweets= [remove_url(tweet) for tweet in all_tweets]
all_tweets[:50]



#Code for Generating Words with frequencies


all_words_no_urls = list(itertools.chain(*words_in_tweet))

counts_no_urls = collections.Counter(all_words_no_urls)

counts_no_urls.most_common(60)



#Codes for forming data frame with the most frequent words (Unigram)


clean_tweets_no_urls = pd.DataFrame(counts_no_urls.most_common(60),
                             columns=['words', 'count'])

clean_tweets_no_urls.head()



#Codes for removing stop words


nltk.download('stopwords')
stop_words = set(stopwords.words('english'))
list(stop_words)[0:60]



#Codes returning words after removing stop words


tweets_nsw = [[word for word in tweet_words if not word in stop_words]
for tweet_words in words_in_tweet]

tweets_nsw[0]



#Codes for the new words with the frequency(Stop words removed)


all_words_nsw = list(itertools.chain(*tweets_nsw))

counts_nsw = collections.Counter(all_words_nsw)

counts_nsw.most_common(60)



#Codes for generating Bar Graph with the most frequent words

clean_tweets_nsw = pd.DataFrame(counts_nsw.most_common(15),
                             columns=['words', 'count'])

fig, ax = plt.subplots(figsize=(8, 8))

clean_tweets_nsw.sort_values(by='count').plot.barh(x='words',
                      y='count',
                      ax=ax,
                      color="purple")

ax.set_title("Common Words Found in Tweets (Without Stop Words)")


plt.show()



#Codes for dataframe after removing stopwords (Final Unigram) 


clean_tweets_no_urls = pd.DataFrame(counts_no_urls.most_common(60),
                             columns=['words', 'count'])




clean_tweets_no_urls.head()
