TEMPLATE = app

QT += qml quick

CONFIG += c++14 -Wall

SOURCES += main.cpp \
    logic.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    logic.h
