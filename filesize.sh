# Interactive File Size Check: Write a script that prompts the user for a file path and displays the file size in real-time as the user types (using backspace for corrections). Employ the read command and the du -s command to check size.
#

#!/bin/bash

while true
do
	read -p "enter file path: "  File_path

	if [ -f "$File_path" ]
	then
		File_size=$(du -sh $File_path | cut -f1)

		echo "File size is $File_size"
	else
		echo "Enter the valid file path "
	fi
done

