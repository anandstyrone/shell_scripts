#Objective: Create a script that checks the network health of your server. It should ping a set of predefined IPs or domain names and report any failures along with the timestamp. The script should log this information and send an alert (e.g., via email) if any of the pings fail.
#
#!/bin/bash
hosts=("8.8.8.8" "google.com" "1.1.1.1" "anandmallela.com")

log_file="/var/log/nethealth.log"

recipient="anandstyrone0316@gmail.com"
subject="Network helath monitor"

alert() {

	local failed_host=$1
	local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
	echo "ping failed for $failed_host at $timestamp" | mail -s "$subject" "$recipient"
}

for host in "${hosts[@]}"
do
	if ping -c 2 -W 2 "$host"  >>/dev/null 
	then
		echo "$(date '+%Y-%m-%d %H:%M:%S')  $host is reachable " >> "$log_file"
	else
		echo "$(date '+%Y-%m-%d %H:%M:%S')  $host is unreachable " >> "$log_file"
		alert "$host"
	fi
done
