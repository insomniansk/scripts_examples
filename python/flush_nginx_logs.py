#!/usr/bin/env python3
# Flushing nginx logs script
import os
#alternative verison will need re lib
#import re
DIRS = []
for address, dirs, files in os.walk("/home"):
    DIRS.append(address)
        #if re.search('logs$',address):
            #DIRS.append(address)
#print(DIRS)
DIRS2 = []
for i in DIRS:
    x = i.split('/')
    if len(x) == 4:
        if (x[1] == 'home') and (x[3] == 'logs'):
            DIRS2.append(i)
#print(DIRS2)
for i in DIRS2:
    os.system(f":> {i}'/nginx.access.log'")
