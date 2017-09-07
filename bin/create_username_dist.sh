##gets 1st command line argument
dir=$1

##for loop to retrieve data from failed_login_data.txt in each subdirectory of $dir
for f in $dir/*
do
	awk '{print $4}' $f/failed_login_data.txt >> tempNames.txt
done

## sorts the data in tempNames.txt
sort tempNames.txt >> sortedTempNames.txt

## tabulates instances of each name from sortedTempNames
uniq -c sortedTempNames.txt >> uniqNames.txt

## formats the result of uniqNames to be used in html
awk '{print "\t\tdata.addRow([\x27"$2"\x27, "$1"]);"}' uniqNames.txt  >> toBeGiven.txt

##wraps the contents of toBeGiven.txt with an html formatted header and footer
bin/wrap_contents.sh toBeGiven.txt  html_components/username_dist $dir/username_dist.html

##removes temporary files
rm tempNames.txt
rm sortedTempNames.txt
rm uniqNames.txt
rm toBeGiven.txt
