#!/bin/bash
#
# PROJECT NAME:
#
# Twitter Blocklist's Text Dumper
# daeshfeed.sh v 2.0.0 build 1 (2.0.0.1)
# Wed Apr 22 00:57:54 JST 2015
# License: FreeBSD http://opensource.org/licenses/BSD-2-Clause
# Owner and maintainer: https://twitter.com/OpAntiISIS
#
# PROJECT REQUIREMENT:
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
# 2. blocktogether.org shared url for default blocklist was changed, adjusted to one liner and bash script
# 3. more comments added, changelog added.
# 
# VERSION 2 CHANGELOG AND BUGFIX
#
# 1. supporting handle URL and ID of blocked users
# 2. additional requirement binary: grep
# 3. binary initiation fixed
#
# RESULT:
#
# (1) below are two one liner bash commands : (by default are commented)
#     (use this to trouble shoot or to run script without installation, copy paste the desired code into bash shell & hit enter)
#
# (1.1 for handle name URL output)
# for i in 1 2 3 4 5 6 ; do lynx -useragent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/537.1 Lynx" "https://blocktogether.org/show-blocks/1d77199be4921c7453765d2abc8336105def8b864f5b00814185a815036525502f02b9762bf1a47c01d5c609317673f6?page=$i" -dump | sort -r | sed -n '/References/,/subscriptions/p' | sed '1d' | sed '$d' | cut -c 7- ; done
#
# (1.2. for twitter ID output)
# for i in 1 2 3 4 5 6 ; do lynx -useragent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/537.1 Lynx" "https://blocktogether.org/show-blocks/1d77199be4921c7453765d2abc8336105def8b864f5b00814185a815036525502f02b9762bf1a47c01d5c609317673f6?page=$i" -source  | grep "data-uid=" | grep -E -o "[0-9]{5,}" ; done
#
#
# (2) bash script
#
# USAGE: bash daeshfeed.sh [handle|id] (all UNIX pipes are available)
#
# $ bash daeshfeed.sh handle                  # extracting text data handle URL in stdout
# $ bash daeshfeed.sh id                      # extracting text data twitter ID in stdout
# $ bash daeshfeed.sh                 　      # show USAGE
# $ bash daeshfeed.sh [handle|id] | wc -l     # counting the records
# $ bash daeshfeed.sh [handle|id] >> file.txt # dumping the output into the file
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
# ( there was a changes in OpAntiISIS blocklist URL, I dont know why..
#
#URL="https://blocktogether.org/show-blocks/1ec31aac864b8e3d409d51c3a045733e5d06bb48d7c4839215b4d6e991ee0aa71364d5ebb806f304d82f54326c1c6b24?page="
URL="https://blocktogether.org/show-blocks/1d77199be4921c7453765d2abc8336105def8b864f5b00814185a815036525502f02b9762bf1a47c01d5c609317673f6?page="
PAGE=6    # 1 page = 500 records, in this default value..if you have 2400 records = 5 pages
#
# do not change these values
#
BETWEEN="/References/,/subscriptions/p"
COUNTER=1
UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/537.1"
#
# PROCESS:
#
while 1>2; do
case "$1" in
'id')
    let PAGE=PAGE+1
    while [ $COUNTER -lt $PAGE ]; do
      $LYNX -useragent='$UA'+" Lynx" "$URL"+$COUNTER -source | $GREP "data-uid=" | $GREP -E -o "[0-9]{5,}"
      let COUNTER=COUNTER+1
    done
    break
    ;;
'handle')
    let PAGE=PAGE+1
    while [ $COUNTER -lt $PAGE ]; do
      $LYNX -useragent='$UA'+" Lynx" "$URL"+$COUNTER -dump | $SORT -r | $SED -n "$BETWEEN" | $SED '1d' | $SED '$d' | $CUT -c 7-
      let COUNTER=COUNTER+1
    done
    break
    ;;
*)
    echo $err; echo "daeshfeed.sh v 2.0.0.1 USAGE: bash daeshfeed.sh [handle|id] - OpAntiISIS"; echo
    exit 1
esac; done
#
#
#IMPORTANT NOTE: please comment the exit 0 if you weant to run this script via run.sh interface
exit 0
