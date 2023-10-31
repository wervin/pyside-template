// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T

import Theme 1.0

T.Button {
    id: control

    property var iconColor: QtObject {
        property color normal: Theme.color.neutral200
        property color hover: Theme.color.neutral200
        property color down: Theme.color.neutral750
        property color disabled: Theme.color.neutral200
    }

    property var textColor: QtObject {
        property color normal: Theme.color.neutral200
        property color hover: Theme.color.neutral200
        property color down: Theme.color.neutral750
        property color disabled: Theme.color.neutral200
    }

    property var backgroundColor: QtObject {
        property color normal: Theme.color.neutral750
        property color hover: Theme.color.neutral600
        property color down: Theme.color.neutral200
        property color disabled: Theme.color.neutral700
    }

    implicitWidth: background.implicitWidth + 2 * control.padding
    implicitHeight: background.implicitHeight + 2 * control.padding

    padding: 6
    
    font.pixelSize: 16
    font.family: "Roboto"

    icon.color: !control.enabled ? control.iconColor.disabled : 
                control.down ? control.iconColor.down : 
                control.hovered ? control.iconColor.hover : 
                control.iconColor.normal

    contentItem: IconLabel {
        spacing: control.spacing

        icon: control.icon
        text: control.text
        font: control.font
        color: !control.enabled ? control.textColor.disabled : 
                control.down ? control.textColor.down : 
                control.hovered ? control.textColor.hover : 
                control.textColor.normal
    }

    background: Rectangle {
        implicitWidth: contentItem.implicitWidth
        implicitHeight: contentItem.implicitHeight

        color: !control.enabled ? control.backgroundColor.disabled : 
                control.down ? control.backgroundColor.down : 
                control.hovered ? control.backgroundColor.hover : 
                control.backgroundColor.normal

        Behavior on color {
            ColorAnimation {
                duration: 150
                easing.type: Easing.OutQuad
            }
        }
    }
}
