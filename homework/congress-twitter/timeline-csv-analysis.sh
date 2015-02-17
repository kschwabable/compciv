username=$1

mkdir -p ./data-hold
echo "Fetching tweets for $username into ./data-hold/$username-timeline.csv"

file=data-hold/$username-timeline.csv
t timeline -n 3200 --csv $username > $file

count=$(csvfix order -ifn -fn ID $file | wc -l)
lastdate=$(csvfix order -fn 'Posted at' $file | tail -n 1)

echo "Analyzing $count tweets by $username since $lastdate"

echo "Top 10 hashtags by $username"

csvfix echo $file | grep -oE "#[[:alpha:]]+" | sort | uniq -c -i | \
sort | tail -n 10 | sort -r

echo "Top 10 retweeted users by $username"

csvfix echo $file | grep -oE "RT @[[:alpha:]]+" | cut -c 4- | \
sort | uniq -c | sort | tail -n 10 | sort -r

echo "Top 10 mentioned users (not including retweets) by $username"

csvfix order -fn Text $file | grep -oE "[^RT] @[[:alpha:]]+" | \
cut -c 3- | grep -v "$username" | sort | uniq -c | sort | \
tail -n 10 | sort -r

echo "Top tweeted 10 words with 5+ letters by $username"

csvfix order -fn Text $file | grep -oE ".[[:alpha:]]{5,}" | sed '/^@/d' | sed '/^#/d' | sed '/^\//d' | cut -c 2- | sort | uniq -c | sort | tail -n 10 | sort -r


