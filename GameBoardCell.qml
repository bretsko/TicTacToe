import QtQuick 2.5
import "."

Rectangle {
    id: cell

    signal stateChangedTo(string state)
    signal clicked

    // color:Style.randomColor
    color: Style.cellColor_empty
    border.color: "#5a2569"
    border.width: 5
    antialiasing: true
    state: Player.empty_

    states: [
        State {
            name:  Player.empty_
            PropertyChanges { target: cell; color: Style.cellColor_empty }
        },

        State {
            name: Player.x_
            PropertyChanges { target: cell; color: Style.cellColor_crosses }
        },
        State {
            name: Player.o_;
            PropertyChanges { target: cell; color: Style.cellColor_noughts }

            PropertyChanges { target: cell; radius: height/2 }
        }

    ]

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: cell.clicked()
    }
}
