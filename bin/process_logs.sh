##lab directory
here=$(pwd)

##temp directory
there=$(mktemp -d skratchXXXXXX)

##used for testing
##echo $there

##extracts each tgz file and creates failed_login_data.txt in each sub-directory (the result of extracted tgz files)
for f in "$@"
do
	tarDir=$(basename "$f" .tgz)
	mkdir $there/$tarDir
	tar -xzf $f -C $there/$tarDir
	bin/process_client_logs.sh $there/$tarDir
done

##extracts information from each iteration of failed_login_data.txt
bin/create_username_dist.sh $there

bin/create_hours_dist.sh $there

bin/create_country_dist.sh $there

##combines all the extracted information from the previous 3 scripts
bin/assemble_report.sh $there

##moves the result to the lab directory
cd $there

mv failed_login_summary.html $here

##removes the temp directory
cd ..

rm -r "$there"
