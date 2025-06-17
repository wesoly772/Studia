#!/bin/bash

BACKUP_FILES="/home/kali/Documents/"
SERVER="192.168.158.129"
USERNAME="kali"
PASSWORD="kali"
DST_BACKUP_FOLDER="home//backups_remote"
BACKUP_NAME="$USER_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

if ! [ -e ~/all_backups ]; then
	mkdir ~/all_backups
fi

tar -czf "all_backups/$BACKUP_NAME" "$BACKUP_FILES"

ftp -n "$SERVER" <<END
user $USERNAME $PASSWORD
cd $DST_BACKUP_FOLDER
put "/home/kali/all_backups/$BACKUP_NAME" $BACKUP_NAME
quit
END






