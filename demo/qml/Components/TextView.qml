import QtQuick 6.6
import QtQuick.Controls 6.6

import Theme 1.0

Item {
    id: textView

    property alias content: content
    property alias text: content.text
    property alias textFormat: content.textFormat
    property alias background: scrollView.background

    property Menu menu

    Rectangle {
        anchors.fill: parent
        color: Theme.color.neutral750

        ScrollView {
            id: scrollView

            anchors.fill: parent
            anchors.margins: 10

            contentWidth: availableWidth
            clip: true

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

            background: Rectangle {
                id: bg
                color: Theme.color.neutral750
            }

            TextEdit {
                id: content
                width: scrollView.availableWidth

                cursorVisible: false
                persistentSelection: true

                font.pixelSize: 16
                font.family: "Hack"

                selectionColor: Theme.color.primary800
                selectedTextColor: Theme.color.neutral750

                color: Theme.color.neutral200
                wrapMode: Text.Wrap

                readOnly: true
                selectByMouse: true
                selectByKeyboard: true

                onTextChanged: scrollView.scrollToBottom()
            }

            function scrollToBottom()
            {
                scrollView.contentItem.contentY = content.height < scrollView.contentItem.height ? 0 : content.height - scrollView.contentItem.height
            }
        }

    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.IBeamCursor
        acceptedButtons: Qt.RightButton
        onClicked: function(mouse) {
            if (textView.menu && mouse.button == Qt.RightButton) textView.menu.popup()
        }
    }
}