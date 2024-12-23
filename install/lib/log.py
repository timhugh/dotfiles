# vim:fileencoding=utf-8

import datetime
import os
import sys
from contextlib import contextmanager
from typing import List
import subprocess

__LOG_DIR__ = os.path.join(os.getenv("HOME"), "tmp", "dotfiles")
__DEBUG__ = os.getenv("DEBUG", "false") == "true"

__ANSI_UP__ = "\033[A"
__ANSI_DOWN__ = "\033[B"
__ANSI_CLEAR_LINE__ = "\033[K"

__IN_PROGRESS__ = "⏳"
__SUCCESS__ = "✅"
__FAILURE__ = "❌"
__SKIP__ = "⏭️"

__HEADER_LINE__ = "#" * 80


def __generate_log_file_path__():
    if __DEBUG__:
        return "test.log"
    else:
        return os.path.join(
                __LOG_DIR__,
                "install-" +
                datetime.datetime.now().strftime("%Y-%m-%d-%H:%M:%S") +
                ".log"
                )


__log_file_path__ = os.getenv(
        "DOTFILES_LOG_FILE",
        __generate_log_file_path__()
        )


@contextmanager
def task(name: str):
    try:
        file = open(__log_file_path__, "w")

        task = Task(name, file)
        yield task

        task.finish()
    except Exception as e:
        task.fail(e)
    finally:
        file.close()


class Task:
    def __init__(self, name: str, file):
        self.__name = name
        self.__file = file
        self.__num_lines = 0

        self.log_to_file(f"{__HEADER_LINE__}\n{name}\n{__HEADER_LINE__}")
        self.log_to_screen(f"{__IN_PROGRESS__} {name}")

    def log_to_screen(self, msg: str):
        print(msg, flush=True)
        self.__num_lines += 1

    def log_to_file(self, msg: str):
        print(msg, file=self.__file, flush=True)

    def clear_line(self):
        sys.stdout.write(__ANSI_UP__ + __ANSI_CLEAR_LINE__)

    def command(self, message: str, command: List[str], ignore_errors: bool = False):
        try:
            self.log_to_screen(f"\t{__IN_PROGRESS__} {message}")
            self.log_to_file(f"## {message}")

            result = None
            if command:
                result = subprocess.run(command, capture_output=True)
                self.log_to_file(result.stdout)
                self.log_to_file(result.stderr)
                if result.returncode != 0 and not ignore_errors:
                    self.log_to_screen(result.stdout.decode("utf-8"))
                    self.log_to_screen(result.stderr.decode("utf-8"))
                    raise Exception("Command failed with non-zero exit code")

            self.clear_line()
            self.log_to_screen(f"\t{__SUCCESS__} {message}")
            return result
        except Exception as e:
            self.clear_line()
            self.log_to_screen(f"\t{__FAILURE__} {message}")
            raise e

    def msg(self, message: str):
        self.log_to_screen(f"\t{message}")
        self.log_to_file(f"## {message}")

    def finish(self):
        for n in range(self.__num_lines + 1):
            self.clear_line()
        self.log_to_screen(f"{__SUCCESS__} {self.__name}")

    def fail(self, exception: Exception):
        for n in range(self.__num_lines):
            sys.stdout.write(__ANSI_UP__)
        self.log_to_screen(f"{__FAILURE__} {self.__name}")
        for n in range(self.__num_lines):
            sys.stdout.write(__ANSI_DOWN__)
        self.log_to_screen(f"Error: {exception}")

        self.log_to_file(f"### {self.__name} failed")
        self.log_to_file(f"Error: {exception}")
