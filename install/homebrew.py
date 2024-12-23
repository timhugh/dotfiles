#!/usr/bin/env python3

import os
import sys

file_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(file_dir, "lib"))
import log


def install_homebrew():
    with log.task("Homebrew") as task:
        already_installed = task.command("Checking if Homebrew is installed", ["command", "-v", "/opt/homebrew/bin/brew"]).returncode == 0
        if already_installed:
            task.msg("Homebrew is already installed")
            return

        task.command("Installing Homebrew", ["/bin/bash", "-c", "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"])


install_homebrew()
