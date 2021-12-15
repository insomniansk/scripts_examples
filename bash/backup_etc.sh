#!/bin/bash
date
echo "############### Backing up files on the system... ###############"

backupfilename=serverexample_etc_backup_`date '+%Y-%m-%d'`
backupserveruser=example_user
backupserverip=1.1.1.1

echo "----- tar, then zip etc folder -----"
tar -cvf /home/backup/${backupfilename}.tar /etc/*

gzip /home/backup/${backupfilename}.tar
chmod 666 /home/backup/${backupfilename}.tar.gz

scp /home/backup/${backupfilename}.tar.gz ${backupserveruser}@${backupserverip}:/backup/protocolname/servername || rm /home/backup/${backupfilename}.tar.gz
rm /home/backup/${backupfilename}.tar.gz
echo "############### Completed backing up etc... ###############"
date
