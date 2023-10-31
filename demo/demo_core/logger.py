import logging

from datetime import datetime

from PySide6.QtCore import QObject, QStandardPaths, QDir, Signal, Property, QUrl

from .info import APP_INFO

class InternalLogger(QObject):
    textChanged = Signal()
    errorChanged = Signal()

    def __init__(self) -> None:
        super().__init__()
        self.root_dir = QDir(QStandardPaths.writableLocation(QStandardPaths.StandardLocation.GenericDataLocation))
        self.max_line_count = 100
        self.max_file_count = 200
        self.log_text = []
        self.error = 0

        self.root_dir.mkdir(APP_INFO.APP_NAME)

        if not self.root_dir.exists(APP_INFO.APP_NAME):
            raise IOError("Failed to create logs directory")
        
        if not self.root_dir.cd(APP_INFO.APP_NAME):
            raise IOError("Failed to access logs directory")
        
        self.root_dir.mkdir("logs")
        
        if not self.root_dir.exists("logs"):
            raise IOError("Failed to create logs directory")
        
        if not self.root_dir.cd("logs"):
            raise IOError("Failed to access logs directory")
        
        self._remove_old_files()
        
        filename = f"{APP_INFO.APP_NAME}-{datetime.today().strftime('%Y%m%d-%H%M%S')}.txt"
        self.filepath = self.root_dir.absoluteFilePath(filename)

    @Property(str, notify=textChanged)
    def text(self) -> str:
        return '<br/>'.join(self.log_text)
    
    @Property(int, notify=errorChanged)
    def error(self) -> int:
        return self._error

    @error.setter
    def error(self, val:int) -> None:
        self._error = val
        self.errorChanged.emit()

    @Property(QUrl, constant=True)
    def path(self) -> QUrl:
        return QUrl.fromLocalFile(self.root_dir.absolutePath())
    
    @Property(QUrl, constant=True)
    def file(self) -> QUrl:
        return QUrl.fromLocalFile(self.filepath)
    
    def log(self, record:logging.LogRecord) -> None:
        msg = f'[{record.levelname}] [{record.name}] {record.msg}'
        timestamp = datetime.today().strftime("%d %b %Y %H:%M:%S")

        with open(self.filepath, 'a', encoding="utf-8") as fd:
            fd.write(f'[{timestamp}] {msg}\n')

        if record.levelno == logging.ERROR or record.levelno == logging.CRITICAL:
            self._append(f'<font color = "#FF1F00">{msg}</font>')
            self.error += 1
        elif record.levelno == logging.WARNING:
            self._append(f'<font color = "#FFCC1E">{msg}</font>')
        else:
            self._append(f'{msg}')

    def _append(self, msg:str) -> None:
        self.log_text.append(msg)
        if len(self.log_text) > self.max_line_count:
            self.log_text.pop(0)
        self.textChanged.emit()

    def _remove_old_files(self) -> None:
        files = self.root_dir.entryInfoList(filters=QDir.Filter.Files, sort=QDir.SortFlag.Time)[self.max_file_count:]

        for file in files:
            if not self.root_dir.remove(file.fileName()):
                raise IOError(f"Failed to remove file: {file.fileName()}")
            
class LoggingHandler(logging.Handler):
    internal_logger: InternalLogger

    def __init__(self) -> None:
        super().__init__()
        self.internal_logger = InternalLogger()

    def emit(self, record:logging.LogRecord) -> None:
        self.internal_logger.log(record)

class Logger():
    logging_handler = LoggingHandler()

    def __init__(self, name:str) -> None:
        self.logger = logging.getLogger(name)
        self.logger.setLevel(logging.DEBUG)
        Logger.logging_handler.setLevel(logging.DEBUG)
        self.logger.addHandler(Logger.logging_handler)

    def debug(self, msg:str) -> None:
        self.logger.debug(msg)

    def info(self, msg:str) -> None:
        self.logger.info(msg)

    def warning(self, msg:str) -> None:
        self.logger.warning(msg)

    def error(self, msg:str) -> None:
        self.logger.error(msg)

    def critical(self, msg:str) -> None:
        self.logger.critical(msg)