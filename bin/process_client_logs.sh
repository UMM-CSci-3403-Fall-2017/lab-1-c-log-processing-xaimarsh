#!/bin/bash
dir=$1

cd $dir

touch failed_login_data.txt

for f in ./var/log/*
do
	awk '/Failed password for invalid user (.[A-Z|a-z]*)\s/ {print $1,$2,substr($3,0,2),$11,$13} /Failed password for ([a-zA-z]*) from/ {print $1,$2,substr($3,0,2),$9,$11}' $f >> failed_login_data.txt
done

