dir=$1

for f in $dir/*
do
	awk '{print $4}' $f/failed_login_data.txt >> tempNames.txt
done

sort tempNames.txt >> sortedTempNames.txt

uniq -c sortedTempNames.txt >> uniqNames.txt

awk '{print "\t\tdata.addRow([\x27"$2"\x27, "$1"]);"}' uniqNames.txt  >> toBeGiven.txt

bin/wrap_contents.sh toBeGiven.txt  html_components/username_dist $dir/username_dist.html

##mv username_dist.html $dir

rm tempNames.txt
rm sortedTempNames.txt
rm uniqNames.txt
rm toBeGiven.txt
