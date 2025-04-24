#Countdown with User Input: Write a script that asks the user for a duration in seconds and displays a countdown timer that updates every second until it reaches zero. Combine a loop with the sleep command for real-time updates.
#

#!/bin/bash
read -p "enter countdown duration in seconds : "  Seconds_left

if ! [[ $Seconds_left =~ ^[0-9]+$ ]]
then
	echo "invalid number, please enter positive number"
	exit 1
fi

while  [ $Seconds_left -gt 0 ]
do
	echo "Remaining seconds : $Seconds_left"
	sleep 1
       Seconds_left=$((Seconds_left -1))
done
echo "Time is up !"
