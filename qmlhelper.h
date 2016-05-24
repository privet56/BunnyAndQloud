#ifndef QMLHELPER_H
#define QMLHELPER_H

#include <QObject>
#include <QApplication>
#include <QQmlEngine>

class qmlhelper : public QObject
{
    Q_OBJECT
public:
    explicit qmlhelper(QObject *parent, QApplication* app, QQmlEngine *qmlEngine);

    Q_INVOKABLE void quit();
    Q_INVOKABLE QString getOS();
    Q_INVOKABLE QString getAppDir();
    Q_INVOKABLE QString getAppDirAsUrl();
    Q_INVOKABLE void openUrl(QString url);

    QApplication *app;
    QQmlEngine *qmlEngine;

signals:

public slots:
    void forceQuit();
};

#endif // QMLHELPER_H
