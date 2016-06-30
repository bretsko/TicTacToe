#include "logic.h"

Logic::Logic(QObject *parent) : QObject(parent),gameBoardState(std::make_unique<BoardStateVector>(9,empty)),current_player(player_o)
{
    using namespace std;

    player_string = { {player_x, "X"},{player_o, "O"},{empty,"EMPTY"}};

    //initializing the winning states vector
    auto winningState1 = make_unique<BoardStateSet> (BoardStateSet({0,1,2}));
    auto winningState2 = make_unique<BoardStateSet> (BoardStateSet({3,4,5}));
    auto winningState3 = make_unique<BoardStateSet> (BoardStateSet({6,7,8}));
    auto winningState4 = make_unique<BoardStateSet> (BoardStateSet({0,3,6}));
    auto winningState5 = make_unique<BoardStateSet> (BoardStateSet({1,4,7}));
    auto winningState6 = make_unique<BoardStateSet> (BoardStateSet({2,5,8}));
    auto winningState7 = make_unique<BoardStateSet> (BoardStateSet({0,4,8}));
    auto winningState8 = make_unique<BoardStateSet> (BoardStateSet({2,4,6}));

    winning_states = make_unique<QVector<BoardStateSet>>( QVector<BoardStateSet>({*winningState1,*winningState2,*winningState3,*winningState4,*winningState5,*winningState6,*winningState7,*winningState8})
                                                          );
    m_isVictory = false;
    isGameRunning = true;
    Logic::current_player = player_o;
}

void Logic:: startGame(){
    m_isVictory = false;
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

bool Logic::isVictory() const {
    return m_isVictory;
}

void Logic::restartGame(){
    //if(isGameRunning){
    for (int i = 0;i < 9; ++i){
        if (gameBoardState->at(i) != empty) {
            (*gameBoardState)[i]  = empty;
        }
    }
    // }
    startGame();
}


QString Logic:: makeMove(int idx){
    if(!isGameRunning) return player_string[empty];
    if (!isValidMove(idx)) return player_string[empty];

    QString player_move(player_string[empty]);

    if (current_player == player_o){
        (*gameBoardState)[idx] = player_o;

        if(isWinner(*gameBoardState)){
            m_isVictory = true;
        }
        current_player = player_x;
        player_move = player_string[player_o];

    }else if(current_player == player_x){

        (*gameBoardState)[idx] = player_x;

        if(isWinner(*gameBoardState)){
            m_isVictory = true;
        }

        current_player = player_o;
        player_move = player_string[player_x];
    }

    return player_move;
}


bool Logic::isWinner(const BoardStateVector &board){

    BoardStateVector board_player(board);

    //separating the moves of the current player
    for (int i = 0;i < 9; ++i){
        if (board_player.at(i) != current_player) {
            board_player[i]  = empty;
        }
    }

    std::unique_ptr<BoardStateSet> boardSet (boardVectorToSet(&board_player));
    //(boardVectorToSet(std::move(&board_player)));

    for (int i = 0;i < 8; i++){
        if(boardSet->contains(winning_states->at(i)))
            return true;
    }

    return false;
}


std::unique_ptr<BoardStateSet> Logic::boardVectorToSet(const BoardStateVector *b){

    auto boardSet = std::make_unique<BoardStateSet> (BoardStateSet());

    for (int i = 0;i < 9; ++i){
        if( b->at(i)!= empty){
            boardSet->insert(i);
        }
    }
    return boardSet;
}

bool Logic:: isValidMove(int idx){
    if (gameBoardState->at(idx) == empty ){
        return true;
    }  else return false;
}
