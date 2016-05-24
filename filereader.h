#include <QObject>

class FileReader : public QObject
{
    Q_OBJECT
public:
    explicit FileReader(QObject *parent = 0);

public:
    Q_INVOKABLE QString readFile(const QString &fileName);
};

