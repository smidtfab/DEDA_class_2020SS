[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **trends_hourly_scraper** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml


Name of Quantlet: 'trends_hourly_scraper'

Published in: 'DEDA_Class_2020SS'

Description: 'Scrapes google trends data for keywords bitcoin and BTC using API access'

Keywords: 'scraping, bitcoin, time series, crypto, api, google, trends'

Author: 'Fabian Schmidt'

```

### PYTHON Code
```python

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

```

automatically created on 2020-07-27