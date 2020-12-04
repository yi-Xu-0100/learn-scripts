#!/usr/bin/env python3
# -*- coding:utf-8 -*-
""" 
File Name: rename.py
Author: yi_Xu
Created Time: 2017年07月29日 星期六 13时23分55秒
"""

""" 

rename.py is a tool for rename.

"""




import os
import shutil
def getname(path):
    for filename in os.listdir(path):
        if filename[-2:] in 'py':
            continue
        if os.path.isdir(filename) == True:
            continue
        else:
            yield filename


def rename(path):
    for filename in getname(path):
        name = filename.replace(' ', '').replace('-', '').replace('：', ':')
        new_name = name[:3] + '-' + name[3:]
        pfname = os.path.join(path, filename)
        pname = os.path.join(path, new_name)
        os.rename(pfname, pname)


def getzip(path):
    for filename in os.listdir(path):
        if filename[-3:] in 'zip':
            yield filename


def unzip(path, bakpath):
    error = {}
    for filename in getzip(path):
        name = os.path.join(path, filename)
        print("Extract %s in %s" % (name, bakpath))
        os.system("unzip -t %s '*/*.mp4' -d %s" % (name, bakpath))


def mvFile(bakpath):
    try:
        os.system("find '.' -name '*.mp4' -exec mv {} %s \;" % bakpath)
    except Exception as e:
        print("Error:", e)


if __name__ == '__main__':
    path = '.'
    rename(path)
    bakdir = 'videos'
    bakpath = os.path.join(path, bakdir)
    if os.path.isdir(bakpath) == False:
        os.mkdir(bakpath)
    unzip(path, bakpath)
    mvFile(bakpath)
    for name in os.listdir(bakpath):
        if name[-3:] != 'mp4':
            shutil.rmtree(os.path.join(bakpath, name))
        else:
            for newName in os.listdir(path):
                if name[:3] == newName[:3]:
                    print(os.path.join(bakpath, name),
                          os.path.join(path, newName))
