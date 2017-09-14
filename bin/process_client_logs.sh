#!/bin/bash
dir=$1

for f in $dir/var/log/*
do
	awk '/Failed password for invalid user ([a-zA-Z0-9]*)\s/ {print $1,$2,substr($3,0,2),$11,$13} /Failed password for ([a-zA-Z0-9]*) from/ {print $1,$2,substr($3,0,2),$9,$11}' $f >> $dir/failed_login_data.txt
done

