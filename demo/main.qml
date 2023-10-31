import QtQuick 6.6
import QtQuick.Window 6.6

import Components

Window {
    id: root
    visible: true

    flags: Qt.Window

    minimumWidth: 1280
    minimumHeight: 720

    title: Qt.application.displayName + " " + Qt.application.version

    MainWindow{
        anchors.fill: parent
    }
}