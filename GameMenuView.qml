import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import "."

Item {
    // anchors.fill: parent
    //anchors.centerIn: parent

    anchors.horizontalCenter: parent.horizontalCenter

    property StackView stackView: stackView_

    ListModel {
        id: pageModel
        ListElement {
            title: "New game"
            page: "GameView.qml"
            name: "New game"
        }

        ListElement {
            title: "Change player"
        }

        ListElement {
            title: "Scores"
        }

        ListElement {
            title: "Options"
        }

        ListElement {
            title: "New game"
        }

        ListElement {
            title: "Quit"
        }
    }

    StackView {
        id: stackView_
        anchors.fill: parent

        focus: true
        Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 1) {
                             stackView.pop();
                             event.accepted = true;
                         }

        initialItem: Item {
            ListView {
                model: pageModel

                anchors.fill: parent

                delegate: ListViewDelegate {
                    text: title
                    onClicked: {
                        stackView.push(Qt.resolvedUrl(page))
                    }
                }
            }
        }
    }

}
