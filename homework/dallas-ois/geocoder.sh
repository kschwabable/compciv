#THIS FILE ONLY DOWNLOADS ALL THE GOOGLE COORDINATES NOW
#getting the address for each shooting

mkdir -p 'data-hold/geocodes'
touch data-hold/geocode-files.txt 

cat data-hold/*.html | pup 'table table tr json{}' | 
  jq --raw-output '.[] .children | [ .[2] .text] | @csv' | grep -v 'Location' | tr -d '"' | while read location_line; do 
  	address=$(echo $location_line | tr ' ' '+')

  curl http://maps.googleapis.com/maps/api/geocode/json?address=$address+Dallas+TX  > data-hold/geocodes/$address.json
  sleep 2
  echo "data-hold/geocodes/$address.json" >> data-hold/geocode-files.txt
done

#talk to the $address.json 
#now parse through all the geocodes using jq '.results[0] .geometry .location'
#mkdir tables

#printf 'Address|Latitude|Longitude|' > tables/geocodes.psv
#for file in $(cat data-hold/geocode-files.txt)
#	do 
#	orig_address=$(basename $file '.json' | tr "+" " ")
#	lat=$(cat $file | jq '.results[0] .geometry .location .lat')
#	lng=$(cat $file | jq '.results[0] .geometry .location .lng')
#	printf '%s|%s|%s\n' "$orig_address" "$lat" "$lng" >> tables/geocodes.psv
#done




#cat data-hold/*.html | pup 'table table tr json{}' | 
#   jq --raw-output '.[] .children | [ .[2] .text] | @csv' | grep -v 'Location' | tr -d '"' | while read location_line; do 
 #  	address=$(echo $location_line | tr ' ' '+')
  # 	fname="data-hold/geocodes/$address.json"
#
 #  	lat=$(cat $fname | jq '.results[0] .geometry .location .lat')
 #	lng=$(cat $fname | jq '.results[0] .geometry .location .lng')
 #	echo "$location_line|$lat|$lng"
 #done

