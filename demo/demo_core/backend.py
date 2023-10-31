import enum
import debugpy
import random

from PySide6.QtCore import QObject, QEnum, QThread, Signal, Property, Signal, Slot
from PySide6.QtWidgets import QApplication

from .logger import Logger

class BackendState(QObject):
    @QEnum
    class StateType(enum.IntEnum):
        READY = enum.auto()
        PENDING_REQUEST = enum.auto()
        ERROR_OCCURED = 0xFF

class TaskHandler(QObject):
    
    def __init__(self, backend:'Backend') -> None:
        super().__init__()
        self.backend = backend

    def run(self) -> None:
        if __debug__:
            debugpy.debug_this_thread()

        self.backend.state = BackendState.StateType.READY

        while not QThread.currentThread().isInterruptionRequested():
            if self.backend.state == BackendState.StateType.READY:
                pass
            elif self.backend.state == BackendState.StateType.PENDING_REQUEST:
                self._process_request()
            else:
                raise ValueError("Unknown state")
            QThread.msleep(250)

    def _process_request(self):
        if len(self.backend.queue):
            request = self.backend.queue.pop(0)
            request.callable(*request.args, **request.kwargs)

        if not len(self.backend.queue):
            self.backend.state = BackendState.StateType.READY

class BackendRequest():
    def __init__(self, callable, *args, **kwargs) -> None:
        self.callable = callable
        self.args = args
        self.kwargs = kwargs

class Backend(QObject):
    logger: Logger
    queue: list[BackendRequest]

    stateChanged = Signal()

    def __init__(self, app:QApplication) -> None:
        super().__init__(app)
        self.queue = []
        self._init_logger()
        self._init_task_handler(app)

    @Property(int, notify=stateChanged)
    def state(self) -> int:
        return self._state
    
    @state.setter
    def state(self, val: BackendState.StateType) -> None:
        self._state = val
        self.stateChanged.emit()


    @Slot()
    def logSomething(self):
        nouns = ["cat", "dog", "house", "car", "book", "computer", "river", "mountain", "friend",
                 "family", "city", "tree", "flower", "sun", "moon", "bird", "ocean", "music", "food", "dream"]

        verbs = ["runs", "jumps", "eats", "writes", "sings", "dances", "thinks", "sleeps", "studies", "plays",
                 "creates", "swims", "talks", "listens", "reads", "drives", "climbs", "loves", "laughs", "explores"]

        adverbs = ["quickly", "slowly", "eagerly", "quietly", "loudly", "happily", "sadly", "gently", "roughly",
                   "carefully", "carelessly", "always", "never", "sometimes", "soon", "late", "early", "well", "badly", "often"]

        adjectives = ["happy", "sad", "big", "small", "bright", "dark", "fast", "slow", "loud", "quiet",
                      "strong", "weak", "beautiful", "ugly", "clever", "stupid", "hard", "soft", "tall", "short"]
    
        sentence = ' '.join([random.choice(i) for i in [nouns, verbs, adverbs, adjectives]])
        self.queue.append(BackendRequest(self.logger.info, sentence))
        self.state = BackendState.StateType.PENDING_REQUEST

    def _init_logger(self) -> None:
        self.logger = Logger("BACKEND")

    def _init_task_handler(self, app:QApplication) -> None:
        self.thread = QThread()
        self.task_handler = TaskHandler(self)
        self.task_handler.moveToThread(self.thread)
        self.thread.started.connect(self.task_handler.run)
        app.aboutToQuit.connect(self._close)
        self.thread.start()

    def _close(self):
        self.thread.requestInterruption()
        self.thread.quit()
        self.thread.wait()