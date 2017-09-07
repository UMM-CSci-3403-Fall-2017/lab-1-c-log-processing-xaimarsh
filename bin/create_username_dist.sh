#!/bin/bash
dir=$1
$PATH="wrap_contents.sh"

cd $dir

for f in /*/
do
	awk '{print $4}' /$f/failed_login_data.txt >> tempNames.txt
done

sort tempNames.txt >> sortedTempNames.txt

uniq -c sortedTempNames.txt >> uniqNames.txt

awk '{print "data.addRow([\x27"$2"\x27, "$1"]);"}' uniqNames.txt  >> toBeGiven.txt

## ~/CSCI3403/lab-1-c-log-processing-xaimarsh/bin/wrap_contents.sh toBeGiven.txt  html_components/username_dist username_dist.html

##./wrap_contents.sh toBeGiven.txt  html_components/username_dist username_dist.html
