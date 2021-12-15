#!/usr/bin/env python3
import re
import os
import datetime
import fileinput
filename = r"C:\target_service\target_service.ini"
backup = r"C:\target_service\target_service.ini.bk"
os.system(f"copy {filename} {backup}")
pattern = re.compile(r"^StatedPrecalcTimer='(\d?\d):\d\d:\d\d'")
a = datetime.datetime.now().hour
print(a)
LINES = []
with open(filename, "r") as f:
    for line in f.readlines():
        #print(line)
        m = pattern.search(line)
        if m:
            #print(line)
            line = line.replace(m.group(1), str(a), 1)
            #print(line)
            LINES.append(line)
        else:
            LINES.append(line)
#print(LINES)

            #print(line)
with open(filename, "w") as w:
    for line in LINES:
        w.write(line)
os.system("net stop ServiceName")
os.system("net start ServiceName")
