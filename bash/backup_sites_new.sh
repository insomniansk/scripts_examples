#!/bin/bash
date
echo "############### Backing up files on the system... ###############"

backupfilename=webserver_sites_backup_`date '+%Y-%m-%d'`

echo "----- Now tar, then zip up all files to be saved -----"
find /home/ -type d -name '*.git' > /home/user/exclude.txt
find /home/ -type f -name '*.mp4' >> /home/user/exclude.txt
echo "/home/user" >> /home/user/exclude.txt
tar -cf /home/user/backup/${backupfilename}.tar -X /home/user/exclude.txt /home/*

gzip /home/backup/${backupfilename}.tar
rm /home/user/exclude.txt
chmod 666 /home/backup/${backupfilename}.tar.gz
mount -t nfs -o proto=tcp,port=2049 1.1.1.1:/nfs /mnt/nfs || rm /home/backup/${backupfilename}.tar.gz
mv /home/backup/${backupfilename}.tar.gz /mnt/nfs/servername || rm /home/backup/${backupfilename}.tar.gz
umount /mnt/nfs
echo "############### Completed backing up Sites... ###############"
date
