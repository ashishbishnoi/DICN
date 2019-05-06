#!/bin/bash

#Function for sending message to discord.
discord() {
message="$1"
msg_content=\"$message\"
#Discord Webhook
url='https://discordapp.com/api/webhooks/551622970532036624/fVPVoiZOxvzy1n3iOzoDij-S0jJx45ExYUy2loLPOC_uyEP3oUvugHkiRjyZ1Q4Si57d'
curl -H "Content-Type: application/json" -X POST -d "{\"content\": $msg_content}" $url
}

#Old IP
EXT_IP_FILE="/home/lab/usp/ip"

#Get the current public IP<F9>
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
node client.js
discord "The Public IP of the System has changed. I am restarting the emby-server. I'll be up in a Second"
systemctl restart emby-server
logger -t ipcheck -- IP changed to $CURRENT_IP
fi
