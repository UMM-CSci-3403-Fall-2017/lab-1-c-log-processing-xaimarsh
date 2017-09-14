##Gets first argument passed from the command line
dir=$1

##Loop to find all files in subdirectories of the $dir directory that contains failed_login_data.txt and prints the hour of the of the day in the created file tempHours.txt
for f in $dir/*/
do
        awk '{print $3}' "$f"failed_login_data.txt >> tempHours.txt
done

##Sorts the tempHours.txt by hours of the day (ex. 1 before 9)
sort tempHours.txt >> sortedTempHours.txt

##Gets rid of any repeat data and counts occurences
uniq -c sortedTempHours.txt >> uniqHours.txt

##Formats data to the liking of html
awk '{print "\t\tdata.addRow([\x27"$2"\x27, "$1"]);"}' uniqHours.txt  >> toBeGiven.txt

##Runs our wrap_contents.sh script, and creates a file at $dir/hours_dist.html
bin/wrap_contents.sh toBeGiven.txt  html_components/hours_dist $dir/hours_dist.html

##Removes temporary files
rm tempHours.txt
rm sortedTempHours.txt
rm uniqHours.txt
rm toBeGiven.txt

