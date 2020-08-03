[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **market_scraper** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml


Name of Quantlet: 'market_scraper'

Published in: 'DEDA_Class_2020SS'

Description: 'Scrapes market data for bitcoin from cryptocompare.com using API access'

Keywords: 'scraping, bitcoin, time series, crypto, api'

Author: 'Fabian Schmidt'

```

### PYTHON Code
```python

import requests
import argparse
import pandas as pd

def get_historical_hourly_price(
        symbol,
        comparison_symbol,
        limit,
        aggregate,
        exchange=''):
    """
    Get the historical OHCL of a certain symbol pair for a certain
    exchange
    """
    url = 'https://min-api.cryptocompare.com/data/histohour?fsym={}&tsym={}&limit={}&aggregate={}'\
            .format(symbol.upper(), comparison_symbol.upper(), limit, aggregate)

    if exchange:
        url += '&e={}'.format(exchange)

    page = requests.get(url)
    data = page.json()['Data']
    data_frame = pd.DataFrame(data)
    data_frame['mid'] = data_frame[["high", "low"]].mean(axis=1)
    data_frame = data_frame.set_index('time')
    return data_frame

def parse_args():
    """Parse the args."""
    parser = argparse.ArgumentParser(
        description='Fetch data for analysis')

    parser.add_argument('--s1', type=str, required=True,
                        help='Symbol 1 of pair')
    parser.add_argument('--s2', type=str, required=True,
                        help='Symbol 2 of pair')
    parser.add_argument('--days', type=int, required=True,
                        help='number of days to fetch data')
    return parser.parse_args()

if __name__ == '__main__':
    args = parse_args()
    TIME_DELTA = 1
    hours = int(args.days) * 24
    file_name = 'data/' + args.s1 + '-' + args.s2 + '-' + str(args.days) + '.csv'
    market_data = get_historical_hourly_price(args.s1, args.s2, hours, TIME_DELTA)
    print(f"Saving df to {file_name}")
    market_data.to_csv(file_name)
    print(market_data)
```

automatically created on 2020-07-27