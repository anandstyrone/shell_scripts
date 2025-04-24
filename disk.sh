#Write a script that checks the free disk space on a specific partition  (e.g., `/`) and displays the available space in megabytes (MB) or gigabytes (GB). Update the information periodically (e.g., every minute) using a loop.
#
#!/bin/bash

PARTITION="/"

while true
do
	echo "======monitoring available space======"

	free_space=$(df -h $PARTITION | awk 'NR==2 {print $4}')

	echo "Available free space is : $free_space"

	sleep 5
done
