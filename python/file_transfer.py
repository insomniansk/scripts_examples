#!/usr/bin/env python3
import bot_init
import os

path1 = "/tmp/file1.xls"
path2 = "/tmp/file2.xls"
path3 = "/tmp/file3.xls"
url1 = "http://domain.ru/downloads/file1.xls"
url2 = "http://domain.ru/downloads/file2.xls"
url3 = "http://domain.ru/downloads/file3.xls"


def main(path, url):
    os.system(f"wget -O  {path} {url} ")
    if os.stat(path).st_size > 0:
        os.system(f"mv {path} /home/domain2.ru/www/uploads/")
       #bot_init.bot.send_message("-1001335088237", "Script Works!")
    else:
        bot_init.bot.send_message("-1001335088237",
                                  "Script broken. Pls check it!")


if __name__ == '__main__':
    main(path1, url1)
    main(path2, url2)
    main(path3, url3)
