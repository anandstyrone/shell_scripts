# Simple System Info Display: Write a script that displays essential system information like the current user, hostname, and operating system version in real-time. Update the script to display this information periodically (e.g., every minute). (Use commands like whoami, hostname, and uname -r to retrieve the information).
#
#!/bin/bash

while true
do
	clear
	echo "=======system info========"
	
	echo "user name is : $(whoami)"
	echo "Hostname is  : $(hostname)"
	echo "unmae is : $(uname -r)"
	sleep 5
done


