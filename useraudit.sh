#Objective: Create a script that audits user accounts and file permissions in a system. The script should list all users, their last login time, and check for any files in sensitive directories (like /etc or /var) with permissions that are too permissive (e.g., world-writable files).
#
#!/bin/bash
REPORT="audit_report_$(date '+%Y-%m-%d %H:%M:%S').log"

echo "user and file permission audit report" >> "$REPORT"

echo "List all user in /etc/passwd excluding system users"

awk -F: '$3 >=1000 && $1 != "nobody" {print $1}' /etc/passwd  >> "$REPORT"

echo "last login info for users"  >> "$REPORT"
lastlog | grep -v "Never logged in" >> "$REPORT"

echo "world-writable files in /etc " >> "$REPORT"
find /etc -type f -perm -0002 2>/dev/null >> "$REPORT"

echo "world-writable files in /var " >> "$REPORT"
find /var -type f -perm -0002  2>/dev/null >> "$REPORT" 


echo "audit report completed" >> "$REPORT"
