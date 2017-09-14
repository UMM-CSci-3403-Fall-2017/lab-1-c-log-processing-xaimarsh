mkdir skratch

for f in "$@"
do
	tarDir=$(basename "$f" .tgz)
	mkdir skratch/$tarDir
	tar -xzf $f -C skratch/$tarDir
	bin/process_client_logs.sh skratch/$tarDir
done

bin/create_username_dist.sh skratch

bin/create_hours_dist.sh skratch

bin/create_country_dist.sh skratch

bin/assemble_report.sh skratch

here=$(pwd)

cd skratch

mv failed_login_summary.html $here

rm -rf skratch
