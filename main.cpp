#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "resserver.h"
#include "filereader.h"
#include "qmlhelper.h"

//#include <QtWebEngine/QtWebEngine>

//#define use_3d

#ifdef use_3d
#include <window.h>
#include <Qt3DCore/QEntity>
#include <Qt3DRenderer/qrenderaspect.h>
#include <Qt3DInput/QInputAspect>
#include <Qt3DQuick/QQmlAspectEngine>
#endif

/*
https://developer.blender.org/T31423
crash in ig4icd64.dll with Intel Graphic Card Driver -->
download 'opengl32.dll' from http://download.blender.org/ftp/sergey/softwaregl/{win64|win32}/   (much slower )
*/

/*
if
    FTH: (9104): *** Fault tolerant heap shim applied to current process. This is usually due to previous crashes. ***
then
    del HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers\{yourapp}
 */

/*
 * qrc_3d.cpp(2522606) : fatal error C1060: compiler is out of heap space
*/

//#define use_3d

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

//    QtWebEngine::initialize();

#ifdef use_3d
    app.quitOnLastWindowClosed();
    Qt3D::Quick::QQmlAspectEngine engine;

    engine.aspectEngine()->registerAspect(new Qt3D::QRenderAspect());
    engine.aspectEngine()->registerAspect(new Qt3D::QInputAspect());      //with this line, the app crashes on close
    engine.aspectEngine()->initialize();

    engine.qmlEngine()->rootContext()->setContextProperty("qmlHelper" , new qmlhelper(0, &app, engine.qmlEngine()));
    engine.qmlEngine()->rootContext()->setContextProperty("resServer" , new ResServer(0));
    engine.qmlEngine()->rootContext()->setContextProperty("fileReader", new FileReader(0));
    engine.setSource(QUrl("qrc:/main.qml"));

    Window view;
    QVariantMap data;
    data.insert(QStringLiteral("surface"), QVariant::fromValue(static_cast<QSurface *>(&view)));
    data.insert(QStringLiteral("eventSource"), QVariant::fromValue(&view));
    engine.aspectEngine()->setData(data);
    engine.qmlEngine()->rootContext()->setContextProperty("_window", &view);    // Expose the window as a context property so we can set the aspect ratio

    //QObject::connect((QObject*)engine.qmlEngine(), SIGNAL(quit()), &app, SLOT(quit()));
    QObject::connect((QObject*)engine.qmlEngine(), SIGNAL(quit()), &view, SLOT(close()));
    //QObject::connect((QObject*)engine.qmlEngine(), SIGNAL(quit()), &app, SLOT(closeAllWindows()));

    view.show();
#else
    QQmlApplicationEngine engine;

    //QObject *rootObject = engine.rootObjects().first();rootObject->setProperty("operatingSystem", os);

    engine.rootContext()->setContextProperty("qmlHelper" , new qmlhelper(0, &app, &engine));
    engine.rootContext()->setContextProperty("resServer" , new ResServer(0));
    engine.rootContext()->setContextProperty("fileReader", new FileReader(0));

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
#endif
    return app.exec();
}
