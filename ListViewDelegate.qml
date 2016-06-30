
import QtQuick 2.5

Item {
    id: root
    width:250
    height: 80

    anchors.horizontalCenter: parent.horizontalCenter

    property alias text: textitem.text
    signal clicked

    Rectangle {
        anchors.fill: parent
        color: "gray"
        visible: mouse.pressed
    }

    Text {
        id: textitem
        font.pixelSize: 32
        anchors.centerIn: parent

    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            root.clicked()
        }

        onHoveredChanged: {
            if ( line.height  == 1){
                line.height = root.height
            }else {
                line.height  = 1
            }
        }
    }


    Rectangle {
        id:line
        opacity: 0.3
        radius: height/4
        border.color: "black"
        width:parent.width
        height: 1
    }

}
