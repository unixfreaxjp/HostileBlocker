#!/bin/bash
#
# PROJECT NAME:
#
# Twitter Blocklist's Text Dumper
# HostileBlocker's HostileFeed.sh v 3.0.0 build 1 (3.0.0.1)
# Tue Jun 16 02:26:44 JST 2015
# License: FreeBSD http://opensource.org/licenses/BSD-2-Clause
#
# INITIAL PROJECT REQUIREMENT:
#
# multi platform OS with below binaries installed
# binaries needed: bash, lynx, sed, cat, cut, sort, sleep
# retry 6 pages..variabled
# setting the UA..variabled
# dump the DATA part only..static
# sort the result..static
# grep blob between "References" and "subscriptions" by sed..static
# delete 1st and last line..static
# delete first 6 chars per line..static
# can be piped into any shell like "| wc" etc etc..static
# target (1) command one liner & (2) bash script
# version 2.0: added control "handle" or "id" parameters for twitter handle and ID output
#
# PURPOSE:
#
# additional twitter safety tool and development for this tool: blocktogether.org
#
# BUILD 2 CHANGELOG
#
# 1. default page is raised to 6 (over 2500 records)
# 2. blocktogether.org blocklist page format was changed, coded Version 3 handle-dump logic
# 3. more comments added, changelog added.
#
# VERSION 2 CHANGELOG AND BUGFIX
#
# 1. supporting handle URL and ID of blocked users
# 2. additional requirement binary: grep
# 3. binary initiation fixed
# 4. build 2 blocklist URL changed
# 5. build 3 data exceeding 3000 changed to support up to 4000
#
# VERSION 3 CHANGELOG
#
# blocktogether.org page layout is changed. Adjustment made.
# Now simply eliminating line with blocktogether, grep twitter
# remember to still cut 1st 6 chars per line
# leaving some initial vars for further changes or dev
#
# RESULT:
#
# (1) below are two one liner bash commands : (by default are commented)
#     (use this to trouble shoot or to run script without installation, copy paste the desired code into bash shell & hit enter)
# (1.1 for handle name URL output)
# for i in 1 2 3 4 5 6 7 8 ; do lynx -useragent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/537.1 Lynx" "https://blocktogether.org/show-blocks/9eb4931b5f36caa8f309feaf528efdec26f52dbea2a37115f274b6f8560d94ac455dc8ded253a25f017b7a17e1265e4b?page=$i" -dump | sed '/blocktogether/ { d; }'|grep 'twitter'|sed '/OpAnt1ISIS/ { d; }' ; done
# (1.2. for twitter ID output)
# for i in 1 2 3 4 5 6 7 8 ; do lynx -useragent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/537.1 Lynx" "https://blocktogether.org/show-blocks/9eb4931b5f36caa8f309feaf528efdec26f52dbea2a37115f274b6f8560d94ac455dc8ded253a25f017b7a17e1265e4b?page=$i" -source  | grep "data-uid=" | grep -E -o "[0-9]{5,}" ; done
#
#
# (2) bash script
#
# USAGE: bash hostilefeed.sh [handle|id] (all UNIX pipes are available)
#
# $ bash hostilefeed.sh handle                  # extracting text data handle URL in stdout
# $ bash hostilefeed.sh id                      # extracting text data twitter ID in stdout
# $ bash hostilefeed.sh                         # show USAGE
# $ bash hostilefeed.sh [handle|id] | wc -l     # counting the records
# $ bash hostilefeed.sh [handle|id] >> file.txt # dumping the output into the file
#
# binaries path;
# (originally coded in Intel Solaris 10/OpenSource, pls adjust your UNIX bins path)
#
SED="/bin/sed"
CUT="/usr/bin/cut"
SORT="/usr/bin/sort"
WC="/usr/bin/wc"
LYNX="/usr/bin/lynx"
GREP="/bin/grep"
#
# blocklist info:
#
URL="https://blocktogether.org/show-blocks/9eb4931b5f36caa8f309feaf528efdec26f52dbea2a37115f274b6f8560d94ac455dc8ded253a25f017b7a17e1265e4b?page="
PAGE=10    # 1 page = 500 records, in this default value..if you have 2400 records = 5 pages
#
# do not change below values..
#
# We don't need this now..museum..
# BETWEEN="/References/,/subscriptions/p"
#
COUNTER=1
UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/537.1"
#
# PROCESS:
#
while true; do
case "$1" in
'id')
    let PAGE=PAGE+1
    while [ $COUNTER -lt $PAGE ]; do
      $LYNX -useragent='$UA'+" Lynx" "$URL"+$COUNTER -source | $GREP "data-uid=" | $GREP -E -o "[0-9]{5,}"
      let COUNTER=COUNTER+1
    done
    break
    ;;
# Version <=2 logic..This is also museum now..
#'handle')
#    let PAGE=PAGE+1
#    while [ $COUNTER -lt $PAGE ]; do
#      $LYNX -useragent='$UA'+" Lynx" "$URL"+$COUNTER -dump | $SORT -r | $SED -n "$BETWEEN" | $SED '1d' | $SED '$d' | $CUT -c 7-
#      let COUNTER=COUNTER+1
#    done
#    break
#    ;;
#
# Version 3 logic
'handle')
    let PAGE=PAGE+1
    while [ $COUNTER -lt $PAGE ]; do
      $LYNX -useragent='$UA'+" Lynx" "$URL"+$COUNTER -dump | $SORT -r | $SED '/blocktogether/ { d; }' | $GREP 'twitter' | $CUT -c 7-
      let COUNTER=COUNTER+1
    done
    break
    ;;
*)
    echo $err; echo "hostilefeed.sh v 3.0.0.1 USAGE: bash hostilefeed.sh [handle|id] - HostileBlocker"; echo
    exit 1
esac; done
#
#
#IMPORTANT NOTE: please comment the exit 0 if you want to run this script via run.sh interface
#exit 0
