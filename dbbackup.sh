# Develop a shell script that automates the backup and restore process for databases such as MySQL or PostgreSQL. The script should dump the database contents, compress them, and store them securely. It should also be able to restore databases from backup files.
#
#!/bin/bash

DB_USER="anand"
DB_PASS="Anand@123"
DB_HOST="localhost"

BACKUP_DIR="/Backup/mysql_$(date +%F)"
log_file="/var/log/sql_backup.log"

mkdir -p "$BACKUP_DIR"

backup_db() {
read -p "Enter database name to back up : "  db
FILE="$BACKUP_DIR/${db}_$(date +%F %H:%M:%S).sql.gz"
echo "Backing up $db...."
mysqldump -u "$DB_USER" -p "$DB_PASS" -h "$DB_HOST" "$db" | gzip > "$FILE"
if [[ $? -eq 0 ]]
then
	echo -e "Back up successful: $FILE"
	echo "$(date) - BACKUP -$db to $FILE" >> "$log_file"
else
	echo "Backup failed for $db"
	echo "$(date) - BACKUP FAILED -$db" >> "$log_file"
fi
}

restore_db() {
read -p "enter full path of the backup file: "  FILE 
read -p "enter database name to restore into : " db

echo "restoring $db from $FILE ..."
gunzip -c "$FILE" | mysql -u "$DB_USER" -p "$DB_PASS" -h "$DB_HOST" "$db"

if [[ $? -eq 0 ]]
then
      	echo -e "Restore successfull into $db"
	echo "$(date) _RESTRORE - $db from $FILE" >> "$log_file"
else
	echo " restored failed "
	echo "$(date) - restored fialed -$db" >> "$log_file"
fi

}

echo "MYSQL backup and restore script"
echo "1) backup database"
echo "2) restore database"
read -p "choose an option : "  option

case $option in 
	1) backup_db ;;
	2) restore_db ;;
	*) echo "not valid" ;;
esac


