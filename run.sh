#!/bin/bash
# simple daeshfeed.sh sample bash user interface
# supported to version 2.0.0 build1 (2.0.0.1)
# NOTE: comment exit 0 in PATH/daeshfeed.sh beforehand!
#Start
    echo "-------------------------------------"
#Delete txt
    echo "      1. Remove previous data"
    /bin/rm -rf PATH/daeshfeed.txt
    sleep 1
#Dumping txt - choose one, by handle or ID  data:
    echo "      2. Dumping remote data in username"
    source PATH/daeshfeed.sh handle >> PATH/daeshfeed.txt
#   echo "      2. Dumping remote data in twitter ID"
#   source PATH/daeshfeed.sh id >> PATH/daeshfeed.txt
    sleep 1
#Counting
    echo "        records: `/bin/cat PATH/daeshfeed.txt | /usr/bin/wc -l`"
    echo
    sleep 1
#Upload txt file to ftp
    echo "      3. Uploading data"
    /usr/bin/expect PATH/ftpuploader.expect
    sleep 1
#End
    sleep 1
    echo
    echo "-------------------------------------"
    echo
exit 0
