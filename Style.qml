pragma Singleton
import QtQuick 2.5

QtObject {

    property int gameBoardWidth: 5

    property color headerColor:  "#aba0b3"

    property color backgroundColor:  "#e14a1d"

    property int textSize: 20
    property int gridSpacing: 20

    property color textColor:Qt.rgba(Math.random(), Math.random(), Math.random(), 1);

    property color cellColor_empty: randomColor
    property color cellColor_crosses:  "#e44a4d"
    property color cellColor_noughts:  "#4a64e4"

    property color cellBorderColor: "#63c8bc"

    property color color_crosses: "#e44a4d"
    property color color_crosses_border: "#e44a4d"

    property color color_noughts: "#4a64e4"
    property color color_noughts_border: "#4a64e4"

    property color randomColor: Qt.rgba(Math.random(), Math.random(), Math.random(), 1);
}
