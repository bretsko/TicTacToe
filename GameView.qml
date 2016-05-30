import QtQuick 2.5
import QtQuick.Window 2.2
import "."

Item {
    id: frame

    function restartGame(){
        gameBoard.clearBoard()
        victoryLabel.hideVictoryMessage()
        Logic.restartGame()
    }

    Column {

        Header{
            id: header

            height: frame.height / 10
            width: parent.width

            Connections {
                target: gameBoard
                onGridStateChangedTo:
                    header.changeLabel(state)
            }
        }

        Rectangle{
            id: gameBoardFrame

            width: frame.width
            height:frame.height

            color: "#cababa"
            radius: 3
            border.color: "#808080"

            GameBoard{
                anchors.verticalCenter:parent.verticalCenter
                anchors.horizontalCenter:parent.horizontalCenter
                // anchors.fill:  parent

                id: gameBoard
                height: frame.height - header.height
                width:height

                onVisibleChanged: {
                    frame.restartGame()
                }
            }

        }


    }

    MouseArea {
        width: (victoryLabel.state == "INITIAL") ? 1 : frame.width
        height: (victoryLabel.state == "INITIAL") ? 1 : frame.height

        onClicked:{
            frame.restartGame()
        }
    }

    Rectangle {
        id: victoryLabel
        state:"INITIAL"

        anchors.centerIn: parent
        color: "#a6d3ab"
        radius: 5
        border.color: "#bac48d"
        visible: true
        border.width: 5
        opacity: 1
        z:3

        function hideVictoryMessage(){
            victoryLabel.state = "INITIAL"
        }

        function showVictoryMessage(winner)
        {
            victoryLabel.state = winner
        }


        Connections {
            target: gameBoard
            onVictory:
                victoryLabel.showVictoryMessage(winner)
        }

        Text {
            id: victoryMessage

            width: implicitWidth
            height: implicitHeight

            color: "#d2d909"
            font.pixelSize:Style.textSize *2
            text: qsTr("")
            font.bold: true
            anchors.fill: parent
            verticalAlignment:Text.AlignBottom
            horizontalAlignment: Text.AlignHCenter

        }

        states: [
            State {
                name: "INITIAL"

                PropertyChanges {
                    target: victoryLabel
                    visible: false
                }

            },
            State {
                name: "O"

                PropertyChanges {
                    target: victoryLabel
                    visible: true
                    z:3
                }

                PropertyChanges {
                    target: victoryMessage
                    color: "blue"
                    text: qsTr("Noughts won!")
                }

            },
            State {
                name: "X"

                PropertyChanges {
                    target: victoryLabel
                    visible: true
                    z:3
                }

                PropertyChanges {
                    target: victoryMessage
                    color: "red"
                    text: qsTr("Crosses won!")
                }

            }
        ]
    }
}



