#Service Monitoring Script: Develop a script that monitors critical system services (e.g., Apache, SSH, MySQL) and restarts them automatically if they are found to be down. Include logging functionality to record service status changes.
#
#
#!/bin/bash
services=("apache2" "sshd")

log_file="/var/log/service_monitor.log"

check_services() {
	for service in "${services[@]}"
	do
		status=$(systemctl is-active "$service")
	
		if [[ "$status" != "active" ]]
		then
			echo "$(date '+%Y-%m-%d %H:%M:%S') - $service is down . we are going restart the $service" >> "$log_file"
			systemctl restart "$service"
			sleep 5
			new_status=$(systemctl is-active "$service")

			if [[ "$new_status" == "active" ]]
			then
				echo "$(date '+%Y-%m-%d %H:%M:%S') - $service successfully restarted " >> "$log_file"
			else
				echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR failed to restart $service " >> "$log_file"
			fi
		else
			echo "$(date '+%Y-%m-%d %H:%M:%S') - $service is running " >> "$log_file"
		fi
	done
}
check_services
