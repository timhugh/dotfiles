import datetime
import os
import sys
from contextlib import contextmanager

__LOG_DIR__ = os.path.join(os.getenv("HOME"), "tmp", "dotfiles")

__ANSI_UP__ = "\033[A"
__ANSI_DOWN__ = "\033[B"
__ANSI_CLEAR_LINE__ = "\033[K"

__IN_PROGRESS__ = "⏳"
__SUCCESS__ = "✅"
__FAILURE__ = "❌"
__SKIP__ = "⏭️"


def __generate_log_file_path__():
    return "test.log"
    # return os.path.join(
    #         __LOG_DIR__,
    #         "install-" +
    #         datetime.datetime.now().strftime("%Y-%m-%d-%H:%M:%S") +
    #         ".log"
    #         )


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

        self.log_to_file(f"### {name} started")
        self.log_to_screen(f"{__IN_PROGRESS__} {name}")

    def log_to_screen(self, msg: str):
        print(msg)
        self.__num_lines += 1

    def log_to_file(self, msg: str):
        print(msg, file=self.__file)

    def clear_line(self):
        sys.stdout.write(__ANSI_UP__ + __ANSI_CLEAR_LINE__)

    def step(self, message: str, callback: callable = None) -> any:
        try:
            self.log_to_screen(f"\t{__IN_PROGRESS__} {message}")
            self.log_to_file(f"\t{message}")

            result = None
            if callback:
                result = callback()

            self.clear_line()
            self.log_to_screen(f"\t{__SUCCESS__} {message}")
            return result
        except Exception as e:
            self.clear_line()
            self.log_to_screen(f"\t{__FAILURE__} {message}")
            raise e

    def finish(self):
        for n in range(self.__num_lines + 1):
            self.clear_line()
        self.log_to_screen(f"{__SUCCESS__} {self.__name}")
        self.log_to_file(f"### {self.__name} finished")

    def fail(self, exception: Exception):
        for n in range(self.__num_lines):
            sys.stdout.write(__ANSI_UP__)
        self.log_to_screen(f"{__FAILURE__} {self.__name}")
        for n in range(self.__num_lines):
            sys.stdout.write(__ANSI_DOWN__)
        self.log_to_screen(f"Error: {exception}")
        self.log_to_file(f"### {self.__name} failed")
        self.log_to_file(f"Error: {exception}")
