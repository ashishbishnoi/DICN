#!/bin/bash

message="Hello There"


#The file that contains the current pubic IP
EXT_IP_FILE="/home/tux/nip"

#Get the current public IP from whatsmyip.com
CURRENT_IP=$(curl https://ipinfo.io/ip)

#Check file for previous IP address
if [ -f $EXT_IP_FILE ]; then
KNOWN_IP=$(cat $EXT_IP_FILE)
else
KNOWN_IP=
fi

#See if the IP has changed
if [ "$CURRENT_IP" != "$KNOWN_IP" ]; then
echo $CURRENT_IP > $EXT_IP_FILE

#If so send an alert
#discord "The Public IP of the System has changed. I am restarting the emby-server. I'll be up in a Second"
echo $message | nc -q 1 192.168.1.2 5555
systemctl restart emby-server
logger -t ipcheck -- IP changed to $CURRENT_IP
#else

#If not just report that it stayed the same
#discord "(TESTING).The Public IP has not changed. System is stable. Enjoy"
#logger -t ipcheck -- NO IP change
fi    
