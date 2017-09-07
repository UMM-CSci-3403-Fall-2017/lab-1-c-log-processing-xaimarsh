wrappedtext=$1
hfname=$2
finalname=$3

cat "$hfname"_header.html $wrappedtext "$hfname"_footer.html > $finalname
