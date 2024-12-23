#!/usr/bin/env python3

import os
import sys

file_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(file_dir, "lib"))
import log


def install_xcode():
    with log.task("Xcode Command Line Tools") as task:
        already_installed = task.command("Checking if tools are installed", ["xcode-select", "-p"]).returncode == 0
        if already_installed:
            task.msg("Tools are already installed")
            return
        task.command("Triggering softwareupdate to show an update", ["touch", "/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"])
        update_list = task.command("Getting update list", ["softwareupdate", "--list"])
        version = None
        for line in update_list.stdout.decode("utf-8").split("\n"):
            if "Label: Command Line Tools" in line:
                version = line.split(":")[1].strip()
                break
        task.command(f"Installing {version}", ["softwareupdate", "--install", version])


install_xcode()
