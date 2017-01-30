import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

//import Qt3D 2.0
//import Qt3D.Renderer 2.0

//import QtCanvas3D 1.0

//import QtWebKit 3.0
//import QtWebKit.experimental 1.0

//import QtWebEngine 1.0

//import "3d"
//import "./js/rabbit3dexplorer.js" as Rabbit3dexplorer

Item
{
    width: 400
    height: 400
    antialiasing: true

    C3d
    {
        id: canvas3d
        anchors.fill:parent
        onRotationStopped:
        {
            if(textureSource)textureSource.z = 1 // Bring the UI to the foreground so that it can be interacted with
        }
        onRotationStarted:
        {
            // Hide the texture source behind canvas to ensure UI cannot be interacted while the phone is rotating.
            if(textureSource)textureSource.z = -1
        }
    }

    /*
    WebEngineView
    {
        id: wv
        anchors.fill:parent
        url: "about:blank"
    }

    Component.onCompleted:
    {
        wv.url = qmlHelper.getAppDirAsUrl()+"/3d/3drabbitexplorer/3drabbitexplorer.html"
    }
    */
}
