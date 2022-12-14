#!/bin/bash
#We need a default environment file to check the difference between the current one.
#We take that file into our script and put current environment into a variable.
default=$(</root/default-env.txt)
env > /root/current-env.txt
current=$(</root/current-env.txt)
#We still check if the default environment file exist.
if [ -e /root/default-env.txt ];
then
    :
else
    echo "file doesn't exist. Please put the file in the script directory."
    exit
fi

sleep 1
#We check the differences between the files and output the last 10 changes.
diff <( cat <<<"$default" ) <( cat <<<"$current" ) | tail -n 15

sleep 1
#Deleting the unneccesary files.
rm -rf /root/current-env.txt

#This script is placed in /etc/profile.d folder.
#And it will be executed in every login.