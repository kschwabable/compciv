touch ~/WWW/compciv/dallasois.html

cat > ~/WWW/compciv/dallasois.html <<'EOF'
<html>
<head>
<style type="text/css">
#description {
	width="200%"
}
</style>
</head>
<body>
<h1>Officer Involved Incidents in Dallas, Texas</h2>
<h2>Incidents</h2>
<table >
EOF

cat tables/incidents.psv | while read -r incident; do
	case_number=$(echo $incident | cut -d '|' -f 1)
	date=$(echo $incident | cut -d '|' -f 2)
	location=$(echo $incident | cut -d '|' -f 3)
	suspect_stat=$(echo $incident | cut -d '|' -f 4)
	suspect_weapon=$(echo $incident | cut -d '|' -f 5)
	suspects=$(echo $incident | cut -d '|' -f 6)
	officers=$(echo $incident | cut -d '|' -f 7)
	grand_jury=$(echo $incident | cut -d '|' -f 8)
	lat=$(echo $incident | cut -d '|' -f 10)
	lng=$(echo $incident | cut -d '|' -f 11)
	description=$(echo $incident | cut -d '|' -f 12)
	
cat >> ~/WWW/compciv/dallasois.html <<EOF
		<tr>
			<td>$case_number</td>
			<td>$date</td>
			<td>$location</td>
			<td>$suspect_stat</td>
			<td>$suspect_weapon</td>
			<td>$suspects</td>
			<td>$officers</td>
			<td>$grand_jury</td>
			<td>$lat</td>
			<td>$lng</td>
			<td class='description'>$description</td>
		</tr>
EOF
done 

cat >> ~/WWW/compciv/dallasois.html <<'EOF'
</table>
<h2>Officers</h2>
<table>

EOF

cat tables/officers.psv | while read -r incident; do
	case_number=$(echo $incident | cut -d '|' -f 1)
	date=$(echo $incident | cut -d '|' -f 2)
	suspect_stat=$(echo $incident | cut -d '|' -f 3)
	suspect_weapon=$(echo $incident | cut -d '|' -f 4)
	last_name=$(echo $incident | cut -d '|' -f 5)
	first_name=$(echo $incident | cut -d '|' -f 6)
	race=$(echo $incident | cut -d '|' -f 7)
	gender=$(echo $incident | cut -d '|' -f 8)

	cat >> ~/WWW/compciv/dallasois.html <<EOF
		<tr>
			<td>$case_number</td>
			<td>$date</td>
			<td>$suspect_stat</td>
			<td>$suspect_weapon</td>
			<td>$last_name</td>
			<td>$first_name</td>
			<td>$race</td>
			<td>$gender</td>
		</tr>
EOF
done 

cat >> ~/WWW/compciv/dallasois.html <<'EOF'
</table>
<h2>Suspects</h2>
<table>
EOF

cat tables/suspects.psv | while read -r incident; do
	case_number=$(echo $incident | cut -d '|' -f 1)
	date=$(echo $incident | cut -d '|' -f 2)
	suspect_weapon=$(echo $incident | cut -d '|' -f 3)
	last_name=$(echo $incident | cut -d '|' -f 4)
	first_name=$(echo $incident | cut -d '|' -f 5)
	race=$(echo $incident | cut -d '|' -f 6)
	gender=$(echo $incident | cut -d '|' -f 7)

	cat >> ~/WWW/compciv/dallasois.html <<EOF
		<tr>
			<td>$case_number</td>
			<td>$date</td>
			<td>$suspect_weapon</td>
			<td>$last_name</td>
			<td>$first_name</td>
			<td>$race</td>
			<td>$gender</td>
		</tr>
EOF
done 

cat >> ~/WWW/compciv/dallasois.html <<'EOF'
</table>
EOF


