import QtQuick 2.5
import QtQuick.Controls 1.4
import "."

Rectangle {
    id: header
    color: Style.headerColor

    signal restartButtonClicked
    signal newGameButtonClicked
    signal quitButtonClicked


    function changeLabel(state){
        if(state == Player.x_){
            label.text = Player.o_name
            player2_light.visible = true
            player1_light.visible = false
        }
        else{
            label.text = Player.x_name
            player1_light.visible = true
            player2_light.visible = false
        }
    }


    Row{
        id: header_layout

        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 4

        Text {
            id: label
            color: "#343b60"

            text: Player.x_name
            font.bold: true
            font.pixelSize: 20
        }

        Rectangle {
            id: player1_light
            visible:false
            height: header.height/2
            width: height
            color: Style.cellColor_crosses
            radius: 5
            border.width: 2
            border.color: "#2f2525"
        }

        Rectangle {
            id: player2_light
            height: header.height/2
            width: height
            color: Style.cellColor_noughts
            radius: height/2
            border.width: 2
            border.color: "#006636"
        }
    }
}
