# Since pytrends is returning a DataFrame object, we need pandas:
import pandas as pd
# Import of pytrends (needs to be pip installed first):
from pytrends.request import TrendReq

pytrends = TrendReq(hl='en-US', tz=360)
kw_list = ['Bitcoin', 'BTC']

search_df = pytrends.get_historical_interest(kw_list, year_start=2020,
                                             month_start=1, day_start=31,
                                             hour_start=0, year_end=2020,
                                             month_end=6, day_end=1, hour_end=0,
                                             cat=0, geo='', gprop='', sleep=60)

search_df.to_csv("data/BTC_trend_complete.csv")
