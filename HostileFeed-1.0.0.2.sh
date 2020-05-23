#!/bin/bash
#
# PROJECT NAME:
#
# Twitter Blocklist's Text Dumper
# HostileBlocker v 1.0.0 built2
# Tue Apr 21 19:03:36 2015
# License: FreeBSD http://opensource.org/licenses/BSD-2-Clause
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
# RESULT:
#
# (1) below is the one liner bash command line: (default is commented)
#     (use this to trouble shoot errors or to run script without installation, copy paste the code into bash shell & hit enter)
#
# for i in 1 2 3 4 5 6 ; do lynx -useragent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/537.1 Lynx" "https://blocktogether.org/show-blocks/1d77199be4921c7453765d2abc8336105def8b864f5b00814185a815036525502f02b9762bf1a47c01d5c609317673f6?page=$i" -dump | sort -r | sed -n '/References/,/subscriptions/p' | sed '1d' | sed '$d' | cut -c 7- ; done 
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
let PAGE=PAGE+1
while [ $COUNTER -lt $PAGE ]; do
  $LYNX -useragent='$UA'+" Lynx" "$URL"+$COUNTER -dump  | $SORT -r | $SED -n "$BETWEEN" | $SED '1d' | $SED '$d' | $CUT -c 7-
  let COUNTER=COUNTER+1
done

#IMPORTANT NOTE: please comment the exit 0 if you weant to run this script via run.sh interface
exit 0
