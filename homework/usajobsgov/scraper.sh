curl -o ./data-hold/OccupationalSeries.xml http://stash.compciv.org/usajobs.gov/OccupationalSeries.xml 

#parse data-hold/OccupationalSeries.xml to find all jobfamily values

jobfamilies=$(hxselect -c -s '\n' 'JobFamily' <data-hold/OccupationalSeries.xml | sort | uniq)

timestamp=$(date +%Y-%m-%d_%H00)
dir="./data-hold/scrapes/$timestamp"
mkdir -p $dir

url="https://data.usajobs.gov/api/jobs?NumberOfJobs=250"

for jobfamily in $jobfamilies; do
	page=1        
    echo "Fetching jobs in $jobfamily, page $page"        
    curl -s "$url&series=$jobfamily&page=$page"  -o "$dir/$jobfamily-$page.json"

    total_pages=$(cat $dir/$jobfamily-1.json | jq --raw-output '.Pages')

    for page in $(seq 2 $total_pages); do
    	echo "Fetching jobs in $jobfamily, page $page"        
    	curl -s "$url&series=$jobfamily&page=$page"  -o "$dir/$jobfamily-$page.json"
    done	
done


