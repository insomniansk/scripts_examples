#!/usr/bin/env python3
import datetime
import tarfile
import os
import re
#import shutil
#import pysftp
import subprocess

# Функция фильтрации содержания архива по папкам (по полному пути) и расширениям ( в данном случае .git и .mp4):
def exclude_func(filename):
    EXCLUDE_MASKS = [".git$", ".mp4$"] # Укажите здесь свои маски в виже строк
    EXCLUDE_DIRS = ["/home/user1", "/home/user2", "/home/user3"] # Укажите абсолютные пути к папкам в виде строк
    for mask in EXCLUDE_MASKS:
        if re.search(mask, filename):
            print(f'Founded mask - {mask}, file {filename} will not be tared')
            return True
    for dirs in EXCLUDE_DIRS:
        if re.search(dirs, filename):
            print(f'Founded mask - {dirs}, this directory will not be tared')
            return True
    return False

#Функция загрузки архива на sftp
def send_sftp(credentials, sftp_path, backupfile_path):
    sp = subprocess.Popen(['sftp', credentials], shell=False, stdin=subprocess.PIPE)
    sp.stdin.write(f"cd {sftp_path}\n".encode('utf-8'))
    sp.stdin.write(f"put {backupfile_path}\n".encode('utf-8'))
    sp.stdin.write("bye\n".encode('utf-8'))
    sp.stdin.close()
    rc=sp.wait()
    return rc

# Смена директории в который создаем архивы
os.chdir(r"/home/backup")

print("############### Backing up sites on the system... ###############")

backupfilename = "webserver_sites_" + datetime.datetime.today().strftime("%Y-%m-%d") + ".tar.gz"
backupfile_path =r"/home/backup/" + backupfilename
print("----- Now tar, then zip up all files to be saved -----")
tar = tarfile.open(backupfilename, "w:gz")
#Блок сбора списка файлов для архивирования
for address, dirs, files in os.walk("/home"):
    for file in files:
        zipfile= address+'/'+file
        if not exclude_func(zipfile):
            tar.add(zipfile, recursive=True)
tar.close
# Connecting to Sftp server using unix commands and remove local copy of archive
credentials="user@1.1.1.1"
sftp_path=r"/backup/sftp/servername/"
if send_sftp(credentials,sftp_path,backupfile_path) == 0:
    os.system (f"rm /home/backup/{backupfilename}")
print("############### Completed backing up sites... ###############")
