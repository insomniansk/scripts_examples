#!/usr/bin/env python3
# Rotation  Old files script
import os
import datetime
PATH = [r"D:\backup\backup1",r"D:\backup\backup2",r"D:\backup\backup3",\
        r"D:\backup\backup4", r"D:\backup\backup5", r"D:\backup\backup6"]
PATH2 = [r"D:\backup\backup7", r"D:\backup\backup8", r"D:\backup\backup9",\
         r"D:\backup\backup10", r"D:\backup\backup11", r"D:\backup\backup12"]
def flushdir(dir, days_count):
    for dirpath, dirnames, filenames in os.walk(dir):
        for file in filenames:
            curpath = os.path.join(dirpath, file)
            file_modified = datetime.datetime.fromtimestamp(os.path.getmtime(curpath))
            if (datetime.datetime.now() - file_modified).days > days_count:
                if file_modified.day != 1:
                    os.remove(curpath)

for path in PATH:
    flushdir(path, 30)
for path in PATH2:
    flushdir(path, 60)
