#Set up a cron job to compress system logs daily at 2:30 AM, delete compressed log files older than 30 days, and email a report of successful and failed compressions to the system administrator.
#
#!/bin/bash

LOG_DIR="/var/log"
REPORT="/tmp/log_report.txt"
EMAIL="anandstyrone0316@gmail.com"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "Log compression report -$DATE" > "$REPORT"
echo "---------------------------------------" >> "$REPORT"

for file in "$LOG_DIR"/*.log
do
	if [ -f "$file" ]
	then
		gzip "$file" 2>>"$REPORT"
		if [ $? -eq 0 ]
		then
			echo "compressed : $file" >> "$REPORT"
		else
			echo "Failed to compress: $file"  >> "$REPORT"
		fi
	fi
done


echo -e "\nDeleting files older than 30 days ..."  >> "$REPORT"
find "$LOG_DIR" -type f -name "*.gz" -mtime +30 -exec rm -f {} \;
if [ $? -eq 0 ]
then
	echo "Old compressed files were successfully deleted." >> "$REPORT"
else
	echo "Failed to delete old compressed files" >> "$REPORT"
fi

mail -s "Daily log compression report" "$EMAIL"  < "$REPORT"

