#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "logic.h"
#include <QQmlContext>
#include <QQuickView>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    Logic logic;
    engine.rootContext()->setContextProperty("Logic", &logic);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
