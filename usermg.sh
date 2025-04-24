#Build a shell script for managing user accounts on a Linux system. The script should allow administrators to add, modify, and delete user accounts, set password policies, and manage user permission
#
#
#!/bin/bash

log_file="/var/log/user_mgmt.log"

report() {
	echo "$(date '+%Y-%m-%d %H:%M:%S')  - $1"  >> "$log_file" 
}

add_user() {
read -p "Enter username: "  username
if [[ -z $username ]]
then
	echo "Username cannot be empty"
	return 1
fi
if id "$username" &>/dev/null 
then
	echo "user $username already exists"
	return 1
fi

sudo useradd -m -s /bin/bash  "$username"
sudo passwd "$username"

echo "User '$username' added successfully"
report "User added : $username"	

	}

####modify user	
modify_user() {
read -p "enter username to modify: " username
if [[  -z $username || ! $(id "username"  2>/dev/null) ]]
then
	echo "Error: user '$username' does not exist"
	return 1
fi

echo "select an option:"
echo "1.change password"
echo "2.change home directory"
read -p "enter your choice: " choice

case $choice in
	1)
		sudo passwd "$username"
		report "password changed for $username" 
		;;

	2) 
	     read -p "enter new home directory: " new_home
	     sudo usermod -d "$new_home" -m "$username"
	     report "home directory changed for $username to $new_home"
		;;

	*) 
		echo "invalid choice"
		;;
esac
}

delete_user() {
read -p "enter username to delete: "  username
if [[  -z $username || ! $(id "username"  2>/dev/null) ]]
then
        echo "Error: user '$username' does not exist"
        return 1
fi
sudo userdel -r "$username"
echo "User '$username' deleted successfully "
report "User deleted : $username"
}

set_pass_policy() {
read -p "enter username to set password policy: " username
if id "$username" &>/dev/null
then
	read -p "max days for change password :" max_days
        read -p "min days for change password :" min_days	
	read -p "warning days for change password :" warn_days

	if [[  $max_days =~ ^[0-9]+$  && $min_days =~ ^[0-9]+$ && $warn_days =~ ^[0-9]+$ ]]
	then
		sudo chage -M "$max_days" -m "$min_days" -W "$warn_days" "$username"
		echo "password policy set for '$username'"
	else
		echo "Error enter positive number"
	fi
else
	echo "User '$username' does not exist!"
fi
}

manage_permissions() {
read -p "Enter username: "  username
if [[  -z $username || ! $(id "username"  2>/dev/null) ]]
then
        echo "Error: user '$username' does not exist"
        return 1
fi

echo "1. Add to group"
echo "2. Remove from group"
read -p "select option: " option
read -p "enter group name: " group

if [[ $option -eq 1 ]]
then
	sudo usermod -aG "$group" "$username"
	echo "User '$username' added to group '$group' "
	report "User $username added to group $group "
elif [[ $option -eq 2 ]]
then
	current_groups=$(id -nG "$username" | sed "s/\b$group\b//g" | xargs)
	sudo usermod -G "$current_groups" "$username"
	echo "User '$username' removed from group '$group'"
	report "User $username removed from group $group "
else
	echo "entered wrong option"
fi
}


while true
do
	echo -e "\nUser Management option:"
	echo "1.Add user"
	echo "2.Modify user"
	echo "3.Delete user"
	echo "4.Set password policy"
	echo "5.manage user permissions"
	echo "6.Exit"
	read -p "Enter your choice: " option


	case $option in 
		1) add_user ;;
                2) modify_user ;;
		3) delete_user ;;
		4) set_pass_policy ;;
		5) manage_permissions ;;
		6) echo "Exiting..."; exit 0 ;;
		*) echo "Invlaid option"

	esac
done


