# slightly malformed input data
input_start=2020-4-30
input_end=2020-5-6

# After this, startdate and enddate will be valid ISO 8601 dates,
# or the script will have aborted when it encountered unparseable data
# such as input_end=abcd
startdate=$(date -I -d "$input_start") || exit -1
enddate=$(date -I -d "$input_end")     || exit -1

# Scrape tweets (n=limit) by day. Has to formulated as a range even
# though it is just a day. Use lib twitterscraper fork that catches rate
# limit hit. Can be installed from https://github.com/EthanZeigler/twitterscraper
d="$startdate"
while [ "$d" != "$enddate" ]; do 
  echo "Scraping tweets on" $d
  bd=$d # set begin date
  d=$(date -I -d "$d + 1 day") # offset day by one to scrape for $d
  fn="data/by_day/tweets_btc_${bd}.csv" # file name
  limit=4000 # tweets per day
  lang="english"
  twitterscraper "Bitcoin AND BTC" -l $limit -bd $bd -ed $d --lang $lang -c -o $fn
done