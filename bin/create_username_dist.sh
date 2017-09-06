dir=$1

cd $dir

for f in /*/
do
	awk '{print $4}' /$f/failed_login_data.txt >> tempNames.txt
done

sort tempNames.txt

uniq -c tempNames.txt >> uniqNames.txt

awk '{print "data.addRow([\x27$2\x27, $1]);"}' >> toBeGiven.txt

##maybe something with bin
./wrap_contents.sh html_components/username_dist_header.html toBegiven.txt html_components_dist_footer.html
