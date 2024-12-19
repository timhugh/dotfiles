#!/usr/bin/env python3

import os
import sys
import time

file_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(file_dir, "lib"))
from log import Task


with Task("Xcode Command Line Tools") as task:
    task.step("Checking if Xcode Command Line Tools are installed")
    time.sleep(1)
    task.step("Installing Xcode Command Line Tools")
    time.sleep(2)
    task.step("Xcode Command Line Tools installed")
