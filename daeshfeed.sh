#!/bin/bash
#
# PROJECT NAME:
#
# Twitter Blocklist's Text Dumper
# daeshfeed.sh v 1.0.0
# Mon Apr 20 16:03:26 JST 2015
# License: FreeBSD http://opensource.org/licenses/BSD-2-Clause
#
# PROJECT REQUIREMENT:
#
# need: bash, lynx, sed, cut, sort
# retry 5 pages..variabled
# setting the UA..variabled
# dump the DATA part only..static
# sort the result..static
# grep blob between "References" and "subscriptions" by sed..static
# delete 1st and last line..static
# delete first 6 chars per line..static
# can be piped into any shell like "| wc" etc etc..static
# target (1) command one liner & (2) bash script
#
# PURPOSE:
#
# additional twitter safety tool and development for this tool: blocktogether.org
#
# RESULT:
#
# (1) one liner bash command line: (default is commented)

# for i in 1 2 3 4 5 6 ; do lynx -useragent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/537.1 Lynx" "https://blocktogether.org/show-blocks/1ec31aac864b8e3d409d51c3a045733e5d06bb48d7c4839215b4d6e991ee0aa71364d5ebb806f304d82f54326c1c6b24?page=$i" -dump  | sort -r | sed -n '/References/,/subscriptions/p' | sed '1d' | sed '$d' | cut -c 7- ; done 
#
#
# (2) bash script
#
# USAGE: (all UNIX pipes are available)
#
# $ bash daeshfeed.sh             # extracting text data in stdout
# $ bash daeshfeed.sh | wc -l     # counting the records
# $ bash daeshfeed.sh >> file.txt # dumping the output into the file
#
# binaries path;
# (coded in Intel Solaris 10/OpenSource, pls adjust your UNIX bins path)
#
SED="/bin/sed"
CUT="/usr/bin/cut"
SORT="/usr/bin/sort"
WC="/usr/bin/wc"
LYNX="/usr/bin/lynx"
#
# blocklist info:
#
URL="https://blocktogether.org/show-blocks/1ec31aac864b8e3d409d51c3a045733e5d06bb48d7c4839215b4d6e991ee0aa71364d5ebb806f304d82f54326c1c6b24?page="
PAGE=5    # 1 page = 500 records, in this default value..if you have 2400 records = 5 pages
#
# do not change these values
#
BETWEEN="/References/,/subscriptions/p" # to be used by sed
COUNTER=1 #dont change this
UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/537.1"
#
# PROCESS:
#
let PAGE=PAGE+1
while [ $COUNTER -lt $PAGE ]; do
  $LYNX -useragent='$UA'+" Lynx" "$URL"+$COUNTER -dump  | $SORT -r | $SED -n "$BETWEEN" | $SED '1d' | $SED '$d' | $CUT -c 7-
  let COUNTER=COUNTER+1
done

exit 0
