dir=$1

##Loop to find all files in subdirectories of the $dir directory that contains failed_login_data.txt and prints the hour of the of the day in the created file tempIP.txt
for f in $dir/*
do
        awk '{print $5}' $f/failed_login_data.txt >> tempIP.txt
done

##sort our ip so that we can utilize join
sort tempIP.txt >> sortedTempIP.txt

##Joins the failed login attempt ip with the corresponding country name
join sortedTempIP.txt etc/country_IP_map.txt >> joinedIP.txt

##Prints all occurences of country names that produced a failed login attempt
awk '{print $2}' joinedIP.txt >> countryOccurences.txt

##Sorts our country names
sort countryOccurences.txt >> sortedCountryOccurences.txt

##Gets rid of any repeat data and counts occurences
uniq -c sortedCountryOccurences.txt >> countryCount.txt

##Formats data to the liking of html
awk '{print "\t\tdata.addRow([\x27"$2"\x27, "$1"]);"}' countryCount.txt  >> toBeGiven.txt

##Runs our wrap_contents.sh script, and creates a file at $dir/country_dist.html
bin/wrap_contents.sh toBeGiven.txt  html_components/country_dist $dir/country_dist.html

##Remove temporary files
rm tempIP.txt
rm sortedTempIP.txt
rm joinedIP.txt
rm countryOccurences.txt
rm sortedCountryOccurences.txt
rm countryCount.txt
rm toBeGiven.txt
