#CREATE INCIDENTS.PSV

echo "Case Number|Date|Location|Suspect Status|Suspect Weapon|Suspect(s)|Officer(s)|Grand Jury Disposition|URL|Latitute|Longitude|Description" > tables/incidents.psv

cat data-hold/*.html | pup 'table table tr json{}' | 
  jq  --raw-output '.[] .children | [ 
    .[0] .children[0] .text, 
    .[1] .text ,
    .[2] .text,
    .[3] .text,
    .[4] .text,
    .[5] .text,
    .[6] .text,
    .[7] .text,
    .[0] .children[0] .href
  ] | @csv' | grep -v 'Location' | csvfix echo -osep '|' | while read -r incident;
do
    pdfurl=$(echo $incident | tr '"' '\n' | grep -E '\b/[[:alpha:]]{3}+' | tr '/' '-')
    pdftotext data-hold/pdfs/$pdfurl data-hold/pdfs/$pdfurl.txt
    pdftxt=$(cat data-hold/pdfs/$pdfurl.txt | tr "[:space:]" " ")
    
    address=$(echo $incident | cut -d '|' -f 3 | tr ' ' '+' | tr '"' ' ' | tr -d ' ')
    fname="data-hold/geocodes/$address.json"
    lat=$(cat $fname | jq '.results[0] .geometry .location .lat')
    lng=$(cat $fname | jq '.results[0] .geometry .location .lng')
    
    echo "$incident|$lat|$lng|$pdftxt" >> tables/incidents.psv
done 


#CREATE OFFICERS.PSV TABLE

echo "Case number|Date|Suspect status|Suspect weapon|Last Name|First Name|Race|Gender" > tables/officers.psv
cat tables/incidents.psv | while read -r incident; do
  
echo $incident | grep -v 'Date' | cut -d '|' -f 7 | sed "s/\/M/\/M#/g" | sed "s/\/F/\/F#/g" | grep -oE "[^#]+" | grep -E "[a-z]" | while read -r another_line;
do
  case_number=$(echo $incident | cut -d '|' -f 1)
  date=$(echo $incident | cut -d '|' -f 2)
  suspect_stat=$(echo $incident | cut -d '|' -f 4)
  
  if [[ $suspect_stat =~ .*Deceased.* ]]
    then
      suspect_status=TRUE
  else 
    suspect_status=FALSE
  fi

 suspect_weapon=$(echo $incident | cut -d '|' -f 5)

  officer=$(echo $another_line)
  
  last_name=$(echo $another_line | grep -oE '\b|[[:alpha:]]+,' | tr -d ',')
  first_name=$(echo $another_line | grep -oE '[[:alpha:]]+ \b' | cut -c 1- | tr -d ' ')
  race=$(echo $another_line | grep -oE '[[:alpha:]]/\b' | tr -d '/')
  gender=$(echo $another_line | grep -oE '\b/[[:alpha:]]' | tr -d '/')
echo "$case_number|$date|$suspect_status|$suspect_weapon|$last_name|$first_name|$race|$gender" | tr -d '"' >> tables/officers.psv
done 
done

#CREATE SUSPECTS.PSV table
echo "Case number|Date|Suspect weapon|Last Name|First Name|Race|Gender" > tables/suspects.psv
cat tables/incidents.psv | while read -r incident; do
  
echo $incident | grep -v 'Date' | cut -d '|' -f 6 | sed "s/\/F/\/F#/g" | sed "s/\/M/\/M#/g" | grep -oE "[^#]+" | grep -E "[a-z]" | while read -r another_line;
do
case_number=$(echo $incident | cut -d '|' -f 1)
date=$(echo $incident | cut -d '|' -f 2)
suspect_weapon=$(echo $incident | cut -d '|' -f 5)

suspect=$(echo $another_line)
  
last_name=$(echo $another_line | grep -oE '\b|[[:alpha:]]+,' | tr -d ',')
first_name=$(echo $another_line | grep -oE '[[:alpha:]]+ \b' | cut -c 1- | tr -d ' ')
race=$(echo $another_line | grep -oE '[[:alpha:]]/\b' | tr -d '/')
gender=$(echo $another_line | grep -oE '\b/[[:alpha:]]' | tr -d '/')
echo "$case_number|$date|$suspect_weapon|$last_name|$first_name|$race|$gender" >> tables/suspects.psv

done 
done




