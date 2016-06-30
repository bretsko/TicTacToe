#ifndef LOGIC_H
#define LOGIC_H

#include <QObject>
#include <QQuickItem>
#include <memory>

enum Player {
    player_x, player_o, empty
};

typedef QVector<Player> BoardStateVector;
typedef QSet<int> BoardStateSet;

class Logic : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isVictory READ isVictory)

public:
    explicit Logic(QObject *parent = 0);

public slots:
    void switchGameState();

    void restartGame();
    bool isValidMove(int idx);
    QString makeMove(int idx);

private:
    Player current_player;

    std::unique_ptr <BoardStateVector> gameBoardState;



    std::unique_ptr<QVector<BoardStateSet>> winning_states;

    std::map<Player, QString > player_string;
    bool m_isVictory;
    bool isGameRunning;

    void startGame();
    void pauseGame();

    std::unique_ptr<BoardStateSet> boardVectorToSet(const BoardStateVector *b);

    bool isWinner(const BoardStateVector &board);
    bool isVictory() const;
};


#endif // LOGIC_H
