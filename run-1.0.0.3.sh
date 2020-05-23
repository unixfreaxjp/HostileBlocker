#!/bin/bash
# simple hostilefeed.sh sample bash user interface
# NOTE: comment exit 0 in PATH/hostilefeed.sh beforehand!
#Start
    echo "-------------------------------------"
#Delete txt
    echo "      1. Remove previous data"
    /bin/rm -rf PATH/hostilefeed.txt
    sleep 1
#Dumping txt
    echo "      2. Dumping remote data"
    source PATH/hostilefeed.sh >> PATH/hostilefeed.txt
    sleep 1
#Counting
    echo "        records: `/bin/cat PATH/hostilefeed.txt | /usr/bin/wc -l`"
    echo
    sleep 1
#Upload txt file to ftp
    echo "      3. Uploading data"
    /usr/bin/expect PATH/ftp-uploader.expect
    sleep 1
#End
    sleep 1
    echo
    echo "-------------------------------------"
    echo
exit 0
