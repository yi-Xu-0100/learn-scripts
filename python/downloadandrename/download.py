#!/usr/bin/env python3
# -*- coding:utf-8 -*-
""" 
File Name: download.py
Author: yi_Xu
Created Time: 2017年07月29日 星期六 09时13分28秒
"""

""" 
download.py is a tool for axel to download more file.

"""




import os
def gettext():
    i = 0
    URL = []
    FileNames = []
    File_URL = {}
    with open('./DownloadsURL.txt', 'r') as text:
        for line in text.readlines():
            i = i+1
            if i % 7 == 3:
                if line.strip().find('/') != -1:
                    FileNames.append(os.path.split(line.strip())[1])
                else:
                    FileNames.append(line.strip())
            elif i % 7 == 0:
                URL.append(line.strip())
    for x in range(len(FileNames)):
        File_URL[FileNames[x]] = URL[x]
    return (File_URL, FileNames)


def Download(FileName, URL, i, n):
    print('''Starting download the %d of %d documents!\r\nFileName = %s''' %
          (i, n, FileName))
    os.system('axel -o %s "%s"' % (FileName, URL))


if __name__ == '__main__':
    File_URL = gettext()[0]
    FileNames = gettext()[1]
    i = 0
    for FileName in FileNames:
        i = i+1
        if ((os.path.isfile(FileName) == True) and (os.path.isfile(FileName+'.st') == False)):
            print("\r\nHere exists %s! Check Problem!\r\n" % FileName)
        else:
            Download(FileName, File_URL[FileName], i, len(FileNames))
