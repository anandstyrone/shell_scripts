# Real-Time Fortune Teller (Simple): Write a script that displays a random fortune message. Use a loop and pre-defined fortunes stored in an array for real-time display.

#!/bin/bash

fortunes=("Keep going" "stay calm" "Take a break" "Crash your goals" "Never give up")

num_fortunes=${#fortunes[@]}

while true
do 
	clear
	random_index=$((RANDOM % num_fortunes))
	echo "your fortune is : "${fortunes[$random_index]}""

	sleep 3
done
