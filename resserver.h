#ifndef RESSERVER_H
#define RESSERVER_H

#include <QObject>

class ResServer : public QObject
{
    Q_OBJECT
public:
    explicit ResServer(QObject *parent = 0);

    Q_INVOKABLE QString unpack(QString sRes);

signals:

public slots:
};

#endif // RESSERVER_H
