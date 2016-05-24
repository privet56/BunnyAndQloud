#include "qmlhelper.h"
#include <QApplication>
//#include <QDebug>
#include <QTimer>
#include <QDesktopServices>
//#include <QAbstractEventDispatcher>

qmlhelper::qmlhelper(QObject *parent, QApplication* app, QQmlEngine *qmlEngine) : QObject(parent)
{
    this->app = app;
    this->qmlEngine = qmlEngine;
}
void qmlhelper::quit()
{   return;
    app->setQuitLockEnabled(false);
    app->closeAllWindows();
    QTimer::singleShot(2, this, SLOT(forceQuit()));
    /*
    QTimer::singleShot(2, this, SLOT(forceQuit()));
    this->qmlEngine->quit();
    app->quit();
    qApp->quit();
    QCoreApplication::quit();
    QGuiApplication::quit();
    QTimer::singleShot(10, app, &QCoreApplication::quit);
    */
}
QString qmlhelper::getAppDir()
{
    return qApp->applicationDirPath().replace('\\', '/');
}
QString qmlhelper::getAppDirAsUrl()
{
    QString sDir = getAppDir();
    if (sDir.startsWith("\\\\") || sDir.startsWith("//"))
        sDir = "file:"+sDir.replace('\\','/');
    else
        sDir = "file:///"+sDir.replace('\\','/');

    return sDir;
}

QString qmlhelper::getOS()
{
    QString os = "windows";
#if defined(Q_OS_WINDOW) || defined(Q_OS_WIN)
    os = "windows";
#elif defined(Q_OS_ANDROID)
    os = "android";
#elif defined(Q_OS_DARWIN) || defined(Q_OS_MAC)  //Darwin-based OS such as OS X and iOS, including any open source version(s) of Darwin.
    os = "darwin";
#endif
    return os;
}
void qmlhelper::forceQuit()
{
    //qDebug() << "forcequit";
    QTimer::singleShot(10, app, &QCoreApplication::quit);
}

void qmlhelper::openUrl(QString url)
{
    QDesktopServices::openUrl(url);
}
