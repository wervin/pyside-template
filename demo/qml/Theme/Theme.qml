pragma Singleton

import QtQuick 6.4

QtObject {
    readonly property var color: QtObject {
        readonly property color transparent: Qt.rgba(0,0,0,0)

        readonly property color primary800: "#ff5733"
        readonly property color primary700: "#ff6c4d"
        readonly property color primary600: "#ff8166"
        readonly property color primary500: "#ff9680"
        readonly property color primary400: "#ffab99"
        readonly property color primary300: "#ffc0b3"
        readonly property color primary200: "#ffd5cc"
        readonly property color primary100: "#ffeae5"

        readonly property color secondary800: "#33dbff"
        readonly property color secondary700: "#4de0ff"
        readonly property color secondary600: "#66e4ff"
        readonly property color secondary500: "#80e9ff"
        readonly property color secondary400: "#99edff"
        readonly property color secondary300: "#b3f2ff"
        readonly property color secondary200: "#ccf6ff"
        readonly property color secondary100: "#e5fbff"

        readonly property color success800: "#018e42"
        readonly property color success700: "#219c5a"
        readonly property color success600: "#41aa71"
        readonly property color success500: "#60b889"
        readonly property color success400: "#80c7a1"
        readonly property color success300: "#a0d5b8"
        readonly property color success200: "#c0e3d0"
        readonly property color success100: "#dff1e7"

        readonly property color warning800: "#ffbd00"
        readonly property color warning700: "#ffc520"
        readonly property color warning600: "#ffce40"
        readonly property color warning500: "#ffd660"
        readonly property color warning400: "#ffde80"
        readonly property color warning300: "#ffe69f"
        readonly property color warning200: "#ffefbf"
        readonly property color warning100: "#fff7df"
 
        readonly property color danger800: "#c2261e"
        readonly property color danger700: "#ca413a"
        readonly property color danger600: "#d15c56"
        readonly property color danger500: "#d97772"
        readonly property color danger400: "#e1938f"
        readonly property color danger300: "#e8aeab"
        readonly property color danger200: "#f0c9c7"
        readonly property color danger100: "#f7e4e3"

        readonly property color neutral800: "#111111"
        readonly property color neutral750: "#212121"
        readonly property color neutral700: "#323232"
        readonly property color neutral650: "#424242"
        readonly property color neutral600: "#535353"
        readonly property color neutral550: "#636363"
        readonly property color neutral500: "#747474"
        readonly property color neutral450: "#848484"
        readonly property color neutral400: "#939393"
        readonly property color neutral350: "#a3a3a3"
        readonly property color neutral300: "#b2b2b2"
        readonly property color neutral250: "#c2c2c2"
        readonly property color neutral200: "#d1d1d1"
        readonly property color neutral150: "#e0e0e0"
        readonly property color neutral100: "#f0f0f0"
        readonly property color neutral50:  "#f8f8f8"
    }
}