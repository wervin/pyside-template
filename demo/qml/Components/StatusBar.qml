import QtQuick 6.6
import QtQuick.Layouts 6.6
import QtQuick.Controls.impl 6.6

import Demo 1.0
import Theme 1.0

Rectangle {
    id: statusBar

    readonly property bool errorOccured: Backend.state == BackendState.ERROR_OCCURED
    color: errorOccured ? Theme.color.danger800 : Theme.color.neutral650
    // radius: 6

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        spacing: 10

        IconImage {
            color: statusBar.errorOccured ? Theme.color.danger800 : Theme.color.neutral200
            sourceSize: Qt.size(22, 22)
            source: "qrc:/assets/icons/info.svg"
        }

        Text {

            text: {
                switch (Backend.state) {
                    case BackendState.READY:
                        return "Ready"
                    case BackendState.PENDING_REQUEST:
                        return "Busy"
                    default:
                        return "Unknown State"
                }
            }

            font.pixelSize: 16
            font.family: "Roboto"

            color: statusBar.errorOccured ? Theme.color.danger800 : Theme.color.neutral200

            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
        }
    }
}