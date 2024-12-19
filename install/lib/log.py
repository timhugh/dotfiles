import datetime
import os
import sys
from contextlib import contextmanager

__LOG_DIR__ = os.path.join(os.getenv("HOME"), "tmp", "dotfiles")

__ANSI_UP__ = "\033[A"
__ANSI_UP_N__ = lambda n: f"\033[{n}A"
__ANSI_DOWN__ = "\033[B"
__ANSI_DOWN_N__ = lambda n: f"\033[{n}B"
__ANSI_CLEAR_LINE__ = "\033[K"

__IN_PROGRESS__ = "⏳"
__SUCCESS__ = "✅"
__FAILURE__ = "❌"


def __generate_log_file_path__():
    return os.path.join(__LOG_DIR__, "install-" + datetime.datetime.now().strftime("%Y-%m-%d-%H:%M:%S") + ".log")


__log_file_path__ = os.getenv("DOTFILES_LOG_FILE", __generate_log_file_path__())


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
        self.__steps = []
        self.__file = file

        print(f"### {self.__name} started", file=self.__file)
        print(f"{__IN_PROGRESS__} {self.__name}")

    def step(self, message: str):
        self.__steps.append(message)
        print(f"\t{message}")
        print(f"\t{message}", file=self.__file)

    def finish(self):
        for n in range(len(self.__steps) + 1):
            sys.stdout.write(__ANSI_UP__ + __ANSI_CLEAR_LINE__)
        print(f"{__SUCCESS__} {self.__name}")

        print(f"### {self.__name} finished", file=self.__file)

    def fail(self, exception: Exception):
        for n in range(len(self.__steps) + 1):
            sys.stdout.write(__ANSI_UP__)
        print(f"{__FAILURE__} {self.__name}")
        for n in range(len(self.__steps) + 1):
            sys.stdout.write(__ANSI_DOWN__)
        print(f"Error: {exception}")

        print(f"### {self.__name} failed", file=self.__file)
