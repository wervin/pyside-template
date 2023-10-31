import json

from PySide6.QtCore import QFile, QIODevice, QTextStream

from . import __resources__

class AppInfo():
    APP_NAME: str
    APP_AUTHOR: str
    APP_PUBLISHER: str
    APP_VERSION: str
    APP_VERSION_MAJOR: int
    APP_VERSION_MINOR: int
    APP_VERSION_REVISION: int

    def __init__(self) -> None:
        file = QFile(':/info.json')
        if not file.open(QIODevice.ReadOnly | QIODevice.Text):
            raise FileNotFoundError("Cannot open info.json")
        rawdata = QTextStream(file)
        info = json.loads(rawdata.readAll())
        file.close()

        self.APP_NAME = info['APP_NAME']
        self.APP_AUTHOR = info['APP_AUTHOR']
        self.APP_VERSION_MAJOR = info['APP_VERSION_MAJOR']
        self.APP_VERSION_MINOR = info['APP_VERSION_MINOR']
        self.APP_VERSION_REVISION = info['APP_VERSION_REVISION']
        self.APP_VERSION = f'v{self.APP_VERSION_MAJOR}.{self.APP_VERSION_MINOR}.{self.APP_VERSION_REVISION}'

APP_INFO = AppInfo()

