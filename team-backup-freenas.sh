#!/bin/bash
# Version 0.2.0

# Rclone backup script
# Run from an hourly cron
# Will not run if backup is already in progress
# Copy mode will copy but not delete (use sync if deletion is desired)
# 8 transfers at a time (default is 4)
# Will run at a max of 5mbps (0.625) during working (8am to 6pm) hours
# --fast-list 
# Verbose output is sent to /var/log/syslog

if pgrep rclone; then
echo "backup already running"
logger Rclone tried to backup, already running. 
exit 1
fi


logger Rclone backup started
/usr/local/bin/rclone copy /mnt/Data/companyfiles vm-companyfiles:vm-companyfiles \
--transfers=8 \
--buffer-size=25M \
--bwlimit "08:00,0.25M 18:00,0.625M" \
--fast-list \
--verbose \
--syslog
logger Rclone backup Finished
exit
