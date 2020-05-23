### You are in HostileBlocker project
This project is meant to support the usage of blocklist in twitter using the BlockTogether tool. 
By this tool you can extract the list of the blocklist in a text file via bash shell command, to help the multipurpose customization and usage for your needs. 

The example of the common USAGE commands is as follows:

```
$ bash hostilefeed.sh             # extracting text data in stdout
$ bash hostilefeed.sh | wc -l     # counting the records
$ bash hostilefeed.sh >> file.txt # dumping the output into the file
```

The tool has just been released for the good purpose only.
If you're using the GitHub for Mac, simply sync your repository and you'll see the new branch.

### License
BSD version 2 Simplified (FreeBSD)

## Requirement
```
Language: bash
Binaries: bash, lynx, sed, cut, sort
Additional: expect is needed for the ftp uploader script
Multi Platform usage can be applied with the adjustment of each binary's path
Tested on: Mc OS X, Solaris 10 Intel, FreeBSD 10 & Debian Wheezy 
```

### Authors and Contributors
This tool is coded by @unixfreaxjp under request from @OpAntiISIS (project owner)
The tool is work as per it is, the coder is not holding any responsiblity for the misusing of the tool.

### Support or Contact
Having trouble with tool? Please contact the owner and he’ll help you sort it out.
