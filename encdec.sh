

#!/bin/bash
#
encrypt_file() {
read -p "Enter file to encrypt: "  file
if [ -f "$file" ]
then
	openssl enc -aes-256-cbc -salt -in "$file" -out "$file.enc"
	echo "File encrypted : $file.enc"
else
	echo "file not found"
fi
}

decrypt_file() {
	read -p "Enter file to decrypt (.enc)"  file
	if  [ -f "$file" ]
	then
		openssl enc -d -aes-256-cbc  -in "$file" -out "${file%.enc}"
		echo "file decrypted: ${1%.enc}"
	else
		echo "file not found"
	fi
}

#main logic

echo "File encryption/decryption tool"
echo "1) Encrypt File"
echo "2) Decrypt File"
read -p "choose an option : "  option

case $option in
	1) encrypt_file ;;
	2) decrypt_file ;;
	*) echo -e "invalid option " ;;
esac
