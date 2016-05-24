import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Particles 2.0

import "src/lists"
import "src/bars"
import "src/buttons"

import "src/variables/fontawesome.js" as FontAwesome

import "./js/main.js" as MainJs
import "./js/BunnyCoverFlowJs.js" as BunnyCoverFlowJs

Item
{
    width: parent.width
    height: parent.height
    id: coverFlowContainer
    anchors.topMargin: 20

    property string token: window.token
    property int loadedImages: 0

    AnimatedImage
    {
        anchors.centerIn: parent
        id: wait
        source: "qrc:/res/wait.gif"
        visible: parent.loadedImages < 6
    }

    PathView
    {
        anchors.fill: parent
        delegate: flipCardDelegate
        model: BunnyCoverFlowJs.bunnyImages()
        path: Path
        {
            startX: root.width/2
            startY: 0
            PathAttribute { name: "itemZ"; value: 0 }
            PathAttribute { name: "itemAngle"; value: -90.0; }
            PathAttribute { name: "itemScale"; value: 0.5; }
            PathLine { x: root.width/2; y: root.height*0.4; }
            PathPercent { value: 0.48; }
            PathLine { x: root.width/2; y: root.height*0.5; }
            PathAttribute { name: "itemAngle"; value: 0.0; }
            PathAttribute { name: "itemScale"; value: 1.0; }
            PathAttribute { name: "itemZ"; value: 100 }
            PathLine { x: root.width/2; y: root.height*0.6; }
            PathPercent { value: 0.52; }
            PathLine { x: root.width/2; y: root.height; }
            PathAttribute { name: "itemAngle"; value: 90.0; }
            PathAttribute { name: "itemScale"; value: 0.5; }
            PathAttribute { name: "itemZ"; value: 0 }
        }
        pathItemCount: 16
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
    }

    Component
    {
        id: flipCardDelegate
        Image
        {
            id: wrapper
            width: parent.width / 2
            antialiasing: true

            visible: PathView.onPath
            scale: PathView.itemScale

            fillMode: Image.PreserveAspectFit

            z: PathView.itemZ
            property variant rotX: PathView.itemAngle
            transform: Rotation
            {
                axis { x: 1; y: 0; z: 0 }
                angle: wrapper.rotX;
                origin { x: 32; y: 32; }
            }

            source: modelData.src

            onStatusChanged: if (status === Image.Ready) coverFlowContainer.loadedImages++;

            MouseArea
            {
                anchors.fill:parent
                onClicked:
                {
                    var page = Qt.resolvedUrl("BunnyImg.qml")
                    page.src = wrapper.source
                    stackView.push(page, {src:wrapper.source})
                    var s = String(wrapper.source)
                    titleBar.title = s.substring(s.lastIndexOf('/')+1)
                }
            }
        }
    }

    MessageDialog
    {
        id: messageDialog
        icon: StandardIcon.Warning
        visible: false
        onAccepted:
        {
            visible = false;
        }
    }
}
