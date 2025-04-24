#Develop a script that analyzes a specified log file (e.g., Apache or Nginx access log) and extracts information such as the most frequent IP addresses and request URLs. The script should also identify any error codes (like 404 or 500) and count their occurrences.
#
#!/bin/bash
log_file="/var/log/apache2/access.log"

if [ ! -f $log_file ]
then
	echo "please enter valid file path"
	exit 1
fi

echo "======analysing log file $log_file========"

echo "=====top 10 most frequent IP addresses====="

awk '{print $1}' $log_file | sort | uniq -c | sort -nr | head -10 

echo "==============================================="

echo "=======top 10 most frequent accessed urls======="

awk -F\ "  '{print $2}' "$log_file" | awk '{print $2}' | sort | uniq -c | sort -nr | head -10

echo "======================================================="

echo "==============error codes =================="

awk '{print $9}' $log_file | grep -E '^4|^5' | sort | uniq -c | sort -nr 

echo "=================================================="
