#Write a script that monitors a specific file for changes. If the file modification time changes, the script displays a message indicating the file has been modified. Use the stat command for comparisons.
#

#!/bin/bash

read -p "enter file name : "   Filename

if [ ! -f "$Filename" ]
then
	echo "file not found enter valid file name"
	exit 1
fi
initial_time=$(stat -c %Y "$Filename")
echo "monitoring teh file $Filename"

while true 
do
	sleep 2
	current_mtime=$(stat -c %Y "$Filename")

	if [ "$initial_time" -ne "$current_mtime" ]
	then
		echo "file $Filename has been modified "
		initial_time=$(current_mtime)
	fi
done	



