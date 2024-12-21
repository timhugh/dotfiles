#!/usr/bin/env python3

import os
import sys
import subprocess

file_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(file_dir, "lib"))
import log


def is_installed() -> bool:
    return subprocess.run(["xcode-select", "-p"], check=False, capture_output=True).returncode == 0


def trigger_install() -> None:
    subprocess.run(["touch", "/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"], capture_output=True, check=True)


def get_latest_version() -> str:
    version = None
    for line in subprocess.run(["softwareupdate", "--list"], capture_output=True, check=True).stdout.decode("utf-8").split("\n"):
        if "Command Line Tools" in line:
            version = line.split("\t")[-1]
            break
    return version


def install_version(version: str) -> None:
    subprocess.run(["softwareupdate", "--install", version], capture_output=True, check=True)


def install_xcode():
    with log.task("Xcode Command Line Tools") as task:
        already_installed = task.step("Checking if tools are installed", lambda: is_installed())
        if already_installed:
            task.step("Tools are already installed")
            return
        task.step("Triggering softwareupdate to show an update", lambda: trigger_install())
        version = task.must_step("Determining lastest version", lambda: get_latest_version())
        task.must_step(f"Installing version {version}", lambda: install_version(version))


install_xcode()
