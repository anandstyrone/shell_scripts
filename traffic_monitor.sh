##Run a script every 5 minutes to collect network traffic statistics. If the incoming traffic exceeds a certain threshold for three consecutive checks, send an email alert to the network administrator.
#
#!/bin/bash

INTERFACE="ens5"
THRESHOLD=1000  
COUNT=0
EMAIL="anandstyrone0316@gmail.com"
SUBJECT="Network Traffic Alert"
TEMP_FILE="/tmp/temp.pcap"

email_alert() {
echo "Alert: Network traffice threshold exceeded for three consecutive checks" mail -s "$SUBJECT" $EMAIL 
}

while true 
do
	tcpdump -i "$INTERFACE" -n -c 500 -w "$TEMP_FILE"  2>/dev/null


	TRAFFIC=$(stat --format="%s" "$TEMP_FILE")
	TRAFFIC_MB=$((TRAFFIC / 1024 / 1024))
	echo "$(date): Traffic: ${TRAFFIC_MB} MB"

	if [ "$TRAFFIC_MB" -gt "$THRESHOLD" ]
	then
		COUNT=$((COUNT +1))
		echo "Traffic threshold exceeded: Count=$COUNT"
	else
		COUNT=0
	fi


	if [ "$COUNT" -ge 3 ]
	then
		email_alert
		COUNT=0
	fi
	rm -f "$TEMP_FILE"
	sleep 300
done
