import QtQuick 2.5
import "."

Grid {
    spacing: Style.gridSpacing
    id: grid_layout

    columns: 3

    signal gridStateChangedTo(string state)
    signal victory (string winner)

    function clearBoard()
    {
        for (var i = 0; i < children.length; i++)
        {
            children[i].state = Player.empty_
        }
    }

    Repeater {
        model: 9

        GameBoardCell{
            id:cell

            width: parent.width/3 - 2 * Style.gridSpacing
            height: width

            onClicked:{

                var newState = Logic.makeMove(index)

                if (newState != Player.empty_)
                {
                    cell.state = newState
                    grid_layout.gridStateChangedTo(newState)
                }

                if (Logic.isVictory == true){

                    //turns off click listener
                    Logic.switchGameState()

                    grid_layout.victory(newState)
                }
            }
        }
    }
}



