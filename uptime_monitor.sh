
#System Uptime Monitor: Write a script that displays the system uptime and refreshes it every 5 seconds. Use the uptime command and a loop to achieve real-time updating.
#
#!/bin/bash

while true
do 
	clear
	uptime_info=$(uptime -p)
	echo "system uptime : $uptime_info"
	sleep 5
done
