import QtQuick 6.6
import QtQuick.Layouts 6.6
import QtQuick.Controls 6.6

import Demo 1.0
import Theme 1.0

Item {
    id: logger

    height: loggerExpand.to

    PropertyAnimation {
        id: loggerExpand
        target: logger
        duration: 100
        property: "height"
        to: 200
    }

    PropertyAnimation {
        id: loggerCollapse
        target: loggerExpand.target
        duration: loggerExpand.duration
        property: loggerExpand.property
        to: 60
    }

    TextView {
        id: logView

        visible: logger.height > loggerCollapse.to

        anchors.top: logger.top
        anchors.right: logger.right
        anchors.left: logger.left
        anchors.bottom: statusLayout.top

        content.textFormat: TextArea.RichText
        content.text: InternalLogger.text

        menu: Menu {
            id: logMenu
            width: 170

            MenuItem {
                text: "Select All"
                onTriggered: logView.content.selectAll()
            }

            MenuItem {
                text: "Copy to clipboard"
                onTriggered: logView.content.copy()
            }

            MenuItem {
                text: "Open full log"
                onTriggered: Qt.openUrlExternally(InternalLogger.file)
            }

            MenuItem {
                text: "Browse all logs"
                onTriggered: Qt.openUrlExternally(InternalLogger.path)
            }
        }
    }

    RowLayout {
        id: statusLayout

        height: 40
        anchors.right: logger.right
        anchors.left: logger.left
        anchors.bottom: logger.bottom

        spacing: 0

        Button {
            id: logButton

            Layout.fillHeight: true

            text: "</>"

            checked: true
            checkable: true

            textColor: QtObject {
                property color normal: logButton.checked ? Theme.color.neutral750 : Theme.color.neutral200
                property color hover: logButton.checked ? Theme.color.neutral750 : Theme.color.neutral200
                property color down: logButton.checked ? Theme.color.neutral750 : Theme.color.neutral200
                property color disabled: logButton.checked ? Theme.color.neutral750 : Theme.color.neutral200
            }

            backgroundColor: QtObject {
                property color normal: InternalLogger.error && !logButton.checked ? Theme.color.danger800 : 
                                        logButton.checked ? Theme.color.secondary700 : Theme.color.neutral650
                property color hover: InternalLogger.error && !logButton.checked ? Theme.color.danger600 : 
                                        logButton.checked ? Theme.color.secondary600 : Theme.color.neutral600
                property color down: InternalLogger.error && !logButton.checked ? Theme.color.danger700 : 
                                        logButton.checked ? Theme.color.secondary500 : Theme.color.neutral550
                property color disabled: Theme.color.neutral750
            }
          
            onCheckedChanged: {
                InternalLogger.error = 0;
                if (checked)
                {
                    if (!loggerCollapse.running)
                        loggerExpand.start();
                    else
                        checked = false;
                }
                else
                {
                    if (!loggerExpand.running)
                        loggerCollapse.start();
                    else
                        checked = true;
                }
            }
        }

        StatusBar {
            id: statusBar
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}