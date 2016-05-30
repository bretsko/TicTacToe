#ifndef LOGIC_H
#define LOGIC_H

#include <QObject>
#include <QQuickItem>

namespace GameLogic{

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
    Player winner;
    BoardStateVector gameBoardState;

    std::map<Player, QString > player_string;
    bool m_isVictory;
    bool isGameRunning;
    bool is_winner(BoardStateVector *b );

    void startGame();
    void pauseGame();

    bool isVictory() const {
        return m_isVictory;
    }
};

}

#endif // LOGIC_H
