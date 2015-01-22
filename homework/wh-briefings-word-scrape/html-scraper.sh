cat data-hold/* | pup 'p, div.legacy-para' | tr '[:lower:]' '[:upper:]' | grep -oE '[[:alpha:]]{7,}' | sort | uniq -c | sort -rn | head -n 10
