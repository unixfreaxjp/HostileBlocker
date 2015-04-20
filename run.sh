#!/bin/bash
# simple daeshfeed.sh sample bash user interface
# NOTE: comment exit 0 in PATH/daeshfeed.sh beforehand!
#Start
    echo "-------------------------------------"
#Delete txt
    echo "      1. Remove previous data"
    /bin/rm -rf PATH/daeshfeed.txt
    sleep 1
#Dumping txt
    echo "      2. Dumping remote data"
    source PATH/daeshfeed.sh >> PATH/daeshfeed.txt
    sleep 1
#Counting
    echo "        records: `/bin/cat PATH/daeshfeed.txt | /usr/bin/wc -l`"
    echo
    sleep 1
#Upload txt file to ftp
    echo "      3. Uploading data"
    /usr/bin/expect PATH/sendfileftp.expect
    sleep 1
#End
    sleep 1
    echo
    echo "-------------------------------------"
    echo
exit 0
