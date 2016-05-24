#include "resserver.h"
#include <QDebug>
#include <QDir>
#include <QFile>
#include <QTemporaryFile>

ResServer::ResServer(QObject *parent) : QObject(parent)
{

}

QString ResServer::unpack(QString sRes)
{

#if defined(Q_OS_ANDROID)
    if(sRes.startsWith(":/"))
        return "qrc"+sRes;
    return sRes;            //MediaPlayer has no problems on Android to play from qrc
#endif

    QString sTo = QDir::tempPath() + sRes.mid(sRes.lastIndexOf('/'));

    if(QFile::exists(sTo))
    {
        qDebug() << "INF: copied already '"+sRes+"' -> '"+sTo+"'";
        return sTo;
    }

    if(!QFile::copy(sRes, sTo))
    {
        qDebug() << "ERR: failed to copy '"+sRes+"' -> '"+sTo+"'";
        return sRes;
    }
    qDebug() << "INF: copy ok '"+sRes+"' -> '"+sTo+"'";
    return sTo;
}
