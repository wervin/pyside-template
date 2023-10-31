import QtQuick 6.6
import QtQuick.Layouts 6.6
import QtQuick.Controls 6.6
import QtQuick3D 6.6

import Demo 1.0
import Theme 1.0

Item {
    id: mainWindow

    Rectangle {
        id: bg
        anchors.fill: parent
        color: Theme.color.neutral700
    }

    Cube {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: logger.top
    }
    
    Logger {
        id: logger
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }
}