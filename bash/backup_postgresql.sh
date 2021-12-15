#!/bin/bash
date
echo "############### Backing up postgresql databases... ###############"

backupfilename=server_psql_backup_`date '+%Y-%m-%d'`

echo "----- Deleting the old file and dumping the current data -----"
mkdir /tmp/sql/
rm -f /tmp/sql/*.sql
chmod 777 -R  /tmp/sql
sudo -u postgres pg_dump -d database_name -f /tmp/sql/database_name.sql
echo "----- Now tar, then zip up all files to be saved -----"
chmod 775 -R /tmp/sql
cd /tmp/sql/
tar -cvf /home/backup/${backupfilename}.tar *

gzip /home/backup/${backupfilename}.tar
chmod 666 /home/backup/${backupfilename}.tar.gz
scp /home/backup/${backupfilename}.tar.gz ${backupserveruser}@${backupserverip}:/backup/protocolname/servername || rm /home/backup/${backupfilename}.tar.gz
rm /home/backup/${backupfilename}.tar.gz
echo "############### Completed backing up PostgreSQL... ###############"
date
