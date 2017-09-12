dir=$1

##Combines our three html files to one file
cat $dir/country_dist.html $dir/hours_dist.html $dir/username_dist.html >> endGame.html

##Uses our wrap_contents.sh script to create a usable html file with all three graphs
bin/wrap_contents.sh endGame.html html_components/summary_plots $dir/failed_login_summary.html

##Remove temp file
rm endGame.html
