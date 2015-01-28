curl -s http://www.tdcj.state.tx.us/death_row/dr_offenders_on_dr.html > data-hold/txdr-current.html

curl -s http://www.tdcj.state.tx.us/death_row/dr_list_all_dr_1923-1973.html > data-hold/txdr-former.html

curl -s http://www.dc.state.fl.us/activeinmates/deathrowroster.asp > data-hold/fldr-current.html

curl -s http://www.dc.state.fl.us/oth/deathrow/execlist.html > data-hold/fldr-former1.html

curl -s  http://www.cdcr.ca.gov/capital_punishment/docs/condemnedinmatelistsecure.pdf > data-hold/cadr.pdf

pdftotext data-hold/cadr.pdf data-hold/cadr.txt
