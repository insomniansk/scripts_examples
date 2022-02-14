#!/bin/bash
#default values
REMOVE=false
INCLUDE=false
EXCLUDE=false
backup_list=("/etc")
backupfilename=serverexample_etc_backup_$(date '+%Y-%m-%d_%H')
destination=/home/backup
compress_level=6
echo "days $days"
#parsing of keys and parameters
while getopts "hb:d:l:vi:x:r:" opt
do
case $opt in
b) #echo "Found the -b option - backup sources list" #debug message
#echo "backup_list = $backup_list" #debug message
backup_list=$OPTARG
#echo "backup_list = $backup_list" #debug message
;;
d) #echo "Found the -d option - backup destination"
destination=$OPTARG
echo "destination path = $destination" #debug message
;;
l)compress_level=$OPTARG
;;
v) #echo "Found the -v option - Verbose tar"
VERBOSE=v
;;
i) if [ $EXCLUDE == true ]
then
  echo "Error : include and exclude options can't be together"
  exit 1
fi
INCLUDE=true
PATTERN=$OPTARG
;;
x)  if [ $INCLUDE == true ]
then
  echo "Error : include and exclude options can't be together"
  exit 1
fi
EXCLUDE=true
PATTERN=$OPTARG
;;
r) REMOVE=true
days=$OPTARG
;;
h) echo "-b "arg1...argn" - backup sources list"
echo "-d arg - backup destination folder"
echo "-l arg - compression level, digit from 1 to 9"
echo "-i|-x "arg1...argn" - list of patterns to include|exclude files in archive"
echo "-r arg - remove backups older than arg days. arg - number"
;;
*) echo "no options chosen"
;;
esac
done

date
echo "############### Backing up files on the system... ###############"

#backupserveruser=example_user
#backupserverip=1.1.1.1

echo "----- tar, then zip your list of folder -----"
# if not set backup_list substitute to default_backup_list

for i in ${backup_list[@]}
do
  for j in ${PATTERN[@]}
  do
  find $i -name $j >> /tmp/list.txt
  done
done
if [ $INCLUDE ]
then
tar -c${VERBOSE}f $destination/${backupfilename}.tar --files-from=/tmp/list.txt

elif [ $EXCLUDE ]
then
  tar -c${VERBOSE}f $destination/${backupfilename}.tar -X /tmp/list.txt
else
  tar -c${VERBOSE}f $destination/${backupfilename}.tar $backup_list
fi
gzip $destination/${backupfilename}.tar -$compress_level
rm /tmp/list.txt
chmod 664 $destination/${backupfilename}.tar.gz

# Retention
if [ $REMOVE == true ]
then
  find $destination -mtime +$days -name "*.tar.gz" | xargs rm -f
fi

#scp /home/backup/${backupfilename}.tar.gz ${backupserveruser}@${backupserverip}:/backup/protocolname/servername || rm /home/backup/${backupfilename}.tar.gz
#rm /home/backup/${backupfilename}.tar.gz
#echo "############### Completed backing up etc... ###############"
#date
