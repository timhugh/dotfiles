import datetime
import os
import sys

__LOG_DIR__ = os.path.join(os.getenv("HOME"), "tmp", "dotfiles")

__ANSI_UP__ = "\033[A"
__ANSI_CLEAR_LINE__ = "\033[K"

__IN_PROGRESS__ = "⏳"
__SUCCESS__ = "✅"
__FAILURE__ = "❌"


def __generate_log_file_path__():
    return os.path.join(__LOG_DIR__, "install-" + datetime.datetime.now().strftime("%Y-%m-%d-%H:%M:%S") + ".log")


__log_file_path__ = os.getenv("DOTFILES_LOG_FILE", __generate_log_file_path__())


class Task:
    def __init__(self, name: str):
        self.__name = name
        self.__steps = []

    def __enter__(self):
        self.__file = open(__log_file_path__, "w")

        print(f"### {self.__name} started", file=self.__file)
        print(f"{__IN_PROGRESS__} {self.__name}")

        return self

    def __exit__(self, _exc_type, _exc_value, _traceback):
        for n in range(len(self.__steps) + 1):
            sys.stdout.write(__ANSI_UP__ + __ANSI_CLEAR_LINE__)

        print(f"### {self.__name} finished", file=self.__file)
        print(f"{__SUCCESS__} {self.__name}")

        if self.__file is not None:
            self.__file.close()

    def step(self, message: str):
        self.__steps.append(message)
        print(f"\t{message}", file=self.__file)
        print(f"\t{message}")
