#!/bin/bash
date
echo "############### Backing up files on the system... ###############"

backupfilename=server_mysql_backup_`date '+%Y-%m-%d'`
backupserveruser=example_user
backupserverip=1.1.1.1
mysql_user=root
mysql_password=your_mysql_root_password

echo "----- Deleting the old file and dumping the current data -----"
mkdir /tmp/sql/
rm -f /tmp/sql/*.sql
mysqldump --user=${mysql_user} --password=${mysql_password} --add-drop-table database1 > /tmp/sql/database1.sql
mysqldump --user=${mysql_user} --password=${mysql_password} --add-drop-table database2 > /tmp/sql/database2.sql
mysqldump --user=${mysql_user} --password=${mysql_password} --add-drop-table database3 > /tmp/sql/database3.sql
echo "----- Now tar, then zip up all files to be saved -----"
cd /tmp/sql/
tar -cvf /home/backup/${backupfilename}.tar *

gzip /home/backup/${backupfilename}.tar
chmod 666 /home/backup/${backupfilename}.tar.gz
scp /home/backup/${backupfilename}.tar.gz ${backupserveruser}@${backupserverip}:/backup/protocolname/servername || rm /home/backup/${backupfilename}.tar.gz
rm /home/backup/${backupfilename}.tar.gz
echo "############### Completed backing up MYSQL... ###############"
date
