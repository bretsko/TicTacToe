#include "logic.h"
#include <memory>

using namespace GameLogic;

bool is_winner(BoardStateVector* b );
Player isWinningCombination(BoardStateVector board);


Logic::Logic(QObject *parent) : QObject(parent),gameBoardState(9,empty),current_player(player_o)
{
    player_string = { {player_x, "X"},{player_o, "O"},{empty,"EMPTY"}};
    m_isVictory = false;
    winner = empty;
    isGameRunning = true;
    Logic::current_player = player_o;
}

void Logic:: startGame(){
    m_isVictory = false;
    winner = empty;
    isGameRunning = true;
    Logic::current_player = player_o;
}

void  Logic:: pauseGame(){
    isGameRunning = false;
}

void  Logic:: switchGameState(){
    if(isGameRunning){
        pauseGame();
        isGameRunning = false;
    }else{
        startGame();
        isGameRunning = true;
    }
}


void Logic::restartGame(){
    //if(isGameRunning){
    for (int i = 0;i < 9; ++i){
        if (gameBoardState.at(i) != empty) {
            gameBoardState[i]  = empty;
        }
    }
    // }
    startGame();
}

bool Logic:: isValidMove(int idx){
    if (gameBoardState.at(idx) == empty ){
        return true;
    }  else return false;
}


QString Logic:: makeMove(int idx){
    if(!isGameRunning) return player_string[empty];
    if (!isValidMove(idx)) return player_string[empty];

    if (current_player == player_o){
        gameBoardState[idx] = player_o;

        winner = isWinningCombination(gameBoardState);

        if(winner != empty){
            m_isVictory = true;
        }

        current_player = player_x;
        return player_string[player_o];
    }else if(current_player == player_x){

        gameBoardState[idx] = player_x;

        winner = isWinningCombination(gameBoardState);

        if(winner != empty){
            m_isVictory = true;
        }

        current_player = player_o;
        return player_string[player_x];
    }
    return player_string[empty];
}

Player isWinningCombination(BoardStateVector board){

    BoardStateVector board_player_x(board);
    BoardStateVector board_player_o(board);

    for (int i = 0;i < 9; ++i){
        if (board_player_x.at(i) != player_x) {
            board_player_x[i]  = empty;
        }
    }

    for (int i = 0;i < 9; ++i){
        if (board_player_o.at(i) != player_o) {
            board_player_o[i]  = empty;
        }
    }


    if (is_winner(&board_player_o)){
        return player_o;
    }
    if (is_winner(&board_player_x)){
        return player_x;
    }
    return empty;
}

BoardStateSet *boardVectorToSet(BoardStateVector * b){

    BoardStateSet * boardSet = new BoardStateSet();

    for (int i = 0;i < 9; ++i){
        if( (*b).at(i)!= empty){
            boardSet->insert(i);
        }
    }
    return boardSet;
}


bool is_winner(BoardStateVector *b ){

    using namespace std;

    static bool init_done = false;
    static QVector<BoardStateSet> winning_states;

    unique_ptr<BoardStateSet> boardSet (boardVectorToSet(b));

    if (!init_done){
        auto winningState1 = make_unique<BoardStateSet> (BoardStateSet());
        auto winningState2 = make_unique<BoardStateSet> (BoardStateSet());
        auto winningState3 = make_unique<BoardStateSet> (BoardStateSet());
        auto winningState4 = make_unique<BoardStateSet> (BoardStateSet());
        auto winningState5 = make_unique<BoardStateSet> (BoardStateSet());
        auto winningState6 = make_unique<BoardStateSet> (BoardStateSet());
        auto winningState7 = make_unique<BoardStateSet> (BoardStateSet());
        auto winningState8 = make_unique<BoardStateSet> (BoardStateSet());

        winningState1->insert(0);
        winningState1->insert(1);
        winningState1->insert(2);

        winningState2->insert(3);
        winningState2->insert(4);
        winningState2->insert(5);

        winningState3->insert(6);
        winningState3->insert(7);
        winningState3->insert(8);

        winningState4->insert(0);
        winningState4->insert(3);
        winningState4->insert(6);

        winningState5->insert(1);
        winningState5->insert(4);
        winningState5->insert(7);

        winningState6->insert(2);
        winningState6->insert(5);
        winningState6->insert(8);

        winningState7->insert(0);
        winningState7->insert(4);
        winningState7->insert(8);

        winningState8->insert(2);
        winningState8->insert(4);
        winningState8->insert(6);

        winning_states.push_back(*winningState1);
        winning_states.push_back(*winningState2);
        winning_states.push_back(*winningState3);
        winning_states.push_back(*winningState4);
        winning_states.push_back(*winningState5);
        winning_states.push_back(*winningState6);
        winning_states.push_back(*winningState7);
        winning_states.push_back(*winningState8);

        init_done = true;
    }

    for (int i = 0;i < 8; i++){
        auto boardStateSet = winning_states.at(i);
        if(boardSet->contains(boardStateSet))return true;
    }

    return false;

}
