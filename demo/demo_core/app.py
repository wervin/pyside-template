import sys
import platform

from PySide6.QtCore import Qt, QCoreApplication
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterSingletonInstance, qmlRegisterUncreatableType
from PySide6.QtGui import QFontDatabase
from PySide6.QtQuickControls2 import QQuickStyle

from .info import APP_INFO
from .logger import Logger, InternalLogger
from .backend import Backend, BackendState

from . import __resources__

class DemoApp():
    app: QApplication
    engine: QQmlApplicationEngine
    logger: Logger
    backend: Backend

    def __init__(self) -> None:
        self._init_core()
        self._init_connection()
        self._init_logger()
        self._init_imports()
        self._init_styles()
        self._init_backend()
        self._init_qml_types()
        self._init_gui()

    def run(self) -> None:
        self.app.aboutToQuit.connect(self.engine.deleteLater)
        sys.exit(self.app.exec())

    def _init_core(self) -> None:
        QCoreApplication.setApplicationName(APP_INFO.APP_NAME)
        QCoreApplication.setApplicationVersion(APP_INFO.APP_VERSION)
        self.app = QApplication()

    def _init_connection(self) -> None:
        pass

    def _init_logger(self) -> None:
        self.logger= Logger("APP")
        self.logger.info(f"{APP_INFO.APP_NAME} {APP_INFO.APP_VERSION}")
        if __debug__:
            self.logger.warning(f"Debug mode is enabled")
            self.logger.warning(f"System Information: {platform.platform()}")
            self.logger.warning(f"Python Interpreter Path: {sys.executable}")
            self.logger.warning(f"Python Version: {sys.version}")
            self.logger.warning(f"Python Path: {sys.path}")

    def _init_imports(self) -> None:
        self.engine = QQmlApplicationEngine()
        self.engine.addImportPath(":/qml")
        self.engine.addImportPath(":/styles")

    def _init_styles(self) -> None:
        # TODO
        QQuickStyle.setStyle("ZenZest")

        QFontDatabase.addApplicationFont("ConsolaMono-Bold.ttf")
        QFontDatabase.addApplicationFont("Hack-Regular.ttf")
        QFontDatabase.addApplicationFont("Jupiteroid-Light.ttf")
        QFontDatabase.addApplicationFont("Roboto-BoldCondensed.ttf")
        QFontDatabase.addApplicationFont("Roboto-Italic.ttf")
        QFontDatabase.addApplicationFont("Roboto-Regular.ttf")
        QFontDatabase.addApplicationFont("ConsolaMono-Book.ttf")
        QFontDatabase.addApplicationFont("Jupiteroid-BoldItalic.ttf")
        QFontDatabase.addApplicationFont("Jupiteroid-Regular.ttf")
        QFontDatabase.addApplicationFont("Roboto-BoldItalic.ttf")
        QFontDatabase.addApplicationFont("Roboto-LightItalic.ttf")
        QFontDatabase.addApplicationFont("Roboto-ThinItalic.ttf")
        QFontDatabase.addApplicationFont("Hack-BoldItalic.ttf")
        QFontDatabase.addApplicationFont("Jupiteroid-Bold.ttf")
        QFontDatabase.addApplicationFont("Roboto-BlackItalic.ttf")
        QFontDatabase.addApplicationFont("Roboto-Bold.ttf")
        QFontDatabase.addApplicationFont("Roboto-Light.ttf")
        QFontDatabase.addApplicationFont("Roboto-Thin.ttf")
        QFontDatabase.addApplicationFont("Hack-Bold.ttf")
        QFontDatabase.addApplicationFont("Jupiteroid-Italic.ttf")
        QFontDatabase.addApplicationFont("Roboto-Black.ttf")
        QFontDatabase.addApplicationFont("Roboto-CondensedItalic.ttf")
        QFontDatabase.addApplicationFont("Roboto-MediumItalic.ttf")
        QFontDatabase.addApplicationFont("Hack-Italic.ttf")
        QFontDatabase.addApplicationFont("Jupiteroid-LightItalic.ttf")
        QFontDatabase.addApplicationFont("Roboto-BoldCondensedItalic.ttf")
        QFontDatabase.addApplicationFont("Roboto-Condensed.ttf")
        QFontDatabase.addApplicationFont("Roboto-Medium.ttf")


    def _init_backend(self) -> None:
        self.backend = Backend(self.app)

    def _init_qml_types(self) -> None:
        qmlRegisterUncreatableType(BackendState, "Demo", 1, 0, "BackendState", "This class is only an enum container")
        qmlRegisterSingletonInstance(InternalLogger, "Demo", 1, 0, "InternalLogger", Logger.logging_handler.internal_logger)
        qmlRegisterSingletonInstance(Backend, "Demo", 1, 0, "Backend", self.backend)

    def _init_gui(self) -> None:
        self.engine.load(':/main.qml')
        if not self.engine.rootObjects():
            sys.exit(-1)