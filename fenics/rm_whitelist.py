#! /usr/bin/env python3

from pathlib import Path
import shutil 
from tempfile import mkdtemp
from sys import argv
import os

def main(dirpath, whitelist):
    dirpath = Path(dirpath)
    tmppath = Path(mkdtemp())
    whitelist = open(whitelist).read().splitlines()

    for f in whitelist:
        f_from = dirpath / f
        dir_to = (tmppath / f).parents[0]
        os.makedirs(dir_to, exist_ok=True)
        print(f"{f_from} --> {dir_to}")
        shutil.copy(str(f_from), str(dir_to))

    shutil.rmtree(str(dirpath)) 
    shutil.move(str(tmppath), str(dirpath))

    # copy whitelist to tmppath
    # for file
    #
    #
    # assert dirpath.is_dir()
    #
    # print(f"Remove everything in {dirpath} except{whitelist}.")
    #
    # delete_me = []
    # for f in dirpath.glob('**/*'):
    #     if f not in whitelist:
    #         delete_me.append(f)
    #
    # print(delete_me)

    # for f in delete_me:
    #     if f.is_file():
    #         f.unlink()
  #
    # for f in delete_me:
        # if f.is_dir() and f.is

def remove_git(dirpath = "/home/fenics/.config/nvim/plugged"):
    for subdir, dirs, files in os.walk(dirpath):
        if ".git" in dirs:
            # subdir contains a .git
            shutil.rmtree(os.path.join(subdir, ".git"))


if __name__ == "__main__":
    try:
        dirpath = argv[1]
    except IndexError:
        dirpath = "h"

    try:
        whitelist = argv[2]
    except IndexError:
        whitelist = "whitelist.txt"

    main(dirpath, whitelist)
#
    remove_git()
