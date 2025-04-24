#!/bin/bash
#
#
#
CONFIG_FILE="cleanup_config.json"

if ! command -v jq  &> /dev/null
then
	echo "jq is not installed. Installing jq  now ... "
	if [ -f /etc/os-release ]
	  then
		. /etc/os-release   ##it loads the variables inside it
		DISTRO=$ID
	else

 	        echo "Cannot determine Linux distribution."
        	exit 1
   	 fi

	 case  "$DISTRO" in
		 ubuntu|debian)
			 sudo apt-get update && sudo apt-get install -y jq ;;

	       	rocky|rhel|centos)
			sudo yum install -y jq ;;
		*)
			echo "unsupported linux distribution : $DISTRO"
			exit 1
			;;
	esac
else
	echo "jq is already installed"
fi

jq -c '.paths[]' "$CONFIG_FILE"  | while read -r entry
do

DIR=$(echo "$entry" | jq -r '.path')
RET_DAYS=$(echo "$entry" | jq -r '.retention_days')
echo "processing directory: $DIR (retention: $RET_DAYS days)"

if [ -d "$DIR" ]
then
	find "$DIR" -type f -name "*.gz"  -mtime +$RET_DAYS -exec rm -f {} \;
	echo "cleaned files older than $RET_DAYS days in $DIR"
else
	echo "ERROR: Directory $DIR does not exist"
fi
done

