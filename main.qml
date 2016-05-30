import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4


ApplicationWindow {
    id: appWindow
    visible: true
    width: 800
    height: 800
    title: qsTr("Noughts and Crosses")

    GameMenuView {
        id : mainMenu
        anchors.fill: parent
        width: parent.width
        height: width
    }

    toolBar: ToolBar {


        width: appWindow.width
        height: implicitHeight

        Button {
            id: backButton
            text: "Back"

            width: opacity ? implicitWidth : 0
            opacity: mainMenu.stackView.depth > 1 ? 1 : 0
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                mainMenu.stackView.pop()
                mainMenu.stackView.currentItem.restartGame()
               // Logic.switchGameState()
            }

            style: ButtonStyle {
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 35
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888"
                    radius: 4
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                        GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                    }
                }
            }
        }

        Text {
            font.pixelSize: 0
            Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            x: backButton.x + backButton.width + 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#312312"
            text: "Noughts and Crosses"
            font.bold: true
            styleColor: "#446497"
        }

        Button {
            id: restartButton
            text: "Restart game"
            onClicked: {
                mainMenu.stackView.currentItem.restartGame()
            }
            anchors.rightMargin: 20
            width: implicitWidth
            opacity: mainMenu.stackView.depth > 1 ? 1 : 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            style: ButtonStyle {
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 35
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888"
                    radius: 4
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                        GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                    }
                }
            }
        }

    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("&New Game")
                onTriggered: mainMenu.stackView.currentItem.restartGame();
            }

            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }
}
