#!/usr/bin/bash

needWrap=$1
desHeadFoot=$2
resultFile=$3

cat "$desHeadFoot"_header.html $needWrap "$desHeadFoot"_footer.html > $resultFile
