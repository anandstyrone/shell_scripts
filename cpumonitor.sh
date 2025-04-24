#Write a script that monitors CPU, memory, and network usage. Utilize libraries like `ncurses` to display them in a user-configurable graphical format (e.g., bar charts, gauges). Allow users to choose the refresh rate and potentially switch between different display modes.
#
#
#!/bin/bash

REFRESH_RATE=2

Display_gauge() {
local value=$1
local max_value=$2
local gauge_length=40
local filled_length=$(((value * gauge_length) /max_value))
local gauge=""

for ((i=0; i<gauge_length; i++)); do
	if ((i < filled_length)); then
		gauge+="#"
	else
		gauge+=" "
	fi
done
echo "[ $gauge ]"

}


get_cpu_usage() {
	usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
	echo "${usage%.*}"
}

get_memory_usage() {

	mem_used=$(free -m | awk '/Mem:/ {print $3}')
	echo "$mem_used"

}

get_network_usage() {
	net_usage=$(netstat -i | grep ens5 | awk '{print $2}')
	echo "$net_usage"
}


while true 
do
	clear
	echo "system resource monitor"
	echo "-----------------------"
	cpu=$(get_cpu_usage)
	echo -n "CPU Usage: "
	Display_gauge "$cpu" 100

	mem=$(get_memory_usage)
	echo =n "Memory Usage: "
	Display_gauge "$mem" 100

	net=$(get_network_usage)
	echo "network usage ens5:  $net"

	sleep 2
done
