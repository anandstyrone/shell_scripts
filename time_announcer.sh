##1. Time Announcer: Write a script that displays a personalized greeting along with the current time every minute. For example, "Good morning, Alice! It's Wednesday, 27 March 2024 11:15 AM." (Use date and a loop to update every minute).
#

#!/bin/bash
echo -n "enter username: "
read name

current_time=$(date "+%A, %d %M %Y %I:%M %p")
Hour=$(date +%H)

while true
do
	if [ "$Hour" -lt 12 ]
	then
		greeting="Good morning"
	elif [ "$Hour" -lt 18 ]
	then
		greeting="Good afternoon"
	else
		greeting="Good evening"
	fi

	echo "$greeting, $name! It's $current_time."
	sleep 60
done
