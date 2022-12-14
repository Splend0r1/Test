#! /bin/bash
#monitor.sh
#Monitoring the system for 24 hours
#Saving the recorded performance.
#This script will be seperate from the "main" script.
date >> /root/status.txt
printf "Memory\t\tDisk\t\tCPU\t\tTIME\n" >> /root/status.txt
end=$((SECONDS+86400))
while [ $SECONDS -lt $end ]; do
DATE=$(date | awk '{printf $5}')
MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')
DISK=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')
CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')
echo "$MEMORY$DISK$CPU$DATE" >> /root/status.txt
sleep 600
done

#Saving the logged in users.
last -x -n 200 -F >> /root/logged-users.txt


--------------------------------------------------

#!/bin/bash
#main.sh
#Checking the file existence
FILE=/root/monitor.sh
if [ -f "$FILE" ]; then
    echo "Monitoring started."
else
    echo "Please make sure Monitor.sh placed in /root"
    echo "Exiting the script."
    exit 1
fi

#Running the monitoring script.

bash /root/monitor.sh
sleep 1

#Sending the necessary mails.
echo "Daily system performance details can be found in the attachments." | mutt -s "Daily Monitoring" -a "/root/logged-users.txt" "/root/status.txt" -- username@gmail.com
sleep 1

#Removing previously created files.
rm -rf /root/status.txt /root/logged-users.txt