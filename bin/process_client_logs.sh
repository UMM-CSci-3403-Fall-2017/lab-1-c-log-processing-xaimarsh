#!/bin/bash
dir=$1

#examines the given directory and checks each line of each file for a regex match. If found, it retrieves the specified information from the line and stores it in a file named "failed_login_data.txt"
for f in $dir/var/log/*
do
	awk '/Failed password for invalid user ([a-zA-Z0-9[:punct:]]*) from/ {print $1,$2,substr($3,0,2),$11,$13} /Failed password for ([a-zA-Z0-9[:punct:]]*) from/ {print $1,$2,substr($3,0,2),$9,$11}' $f >> $dir/failed_login_data.txt
done

##Ghost code from a previous iteration
#do
#        awk '/Failed password for invalid user ([a-zA-Z0-9]*)\s/ {print $1,$2,substr($3,0,2),$11,$13} /Failed password for ([a-zA-Z0-9]*) from/ {print $1,$2,substr($3,0,2),$9,$11}' $f >> $dir/failed_login_data.txt
#done

