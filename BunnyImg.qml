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

Image
{
    id: img
    width: parent.width
    height: parent.height

    property string src: ""
    property variant metaData
    source: src

    fillMode: Image.PreserveAspectFit

    mipmap: true

    Component.onCompleted:
    {

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

    MouseArea
    {
        anchors.fill: parent
        drag.target: parent
        drag.axis: Drag.XandYAxis
        onClicked:
        {
            img.width  += 111
            img.height += 111
            if( img.width > (window.width * 5))
            {
                img.width = img.parent.width
                img.height = img.parent.height
            }
        }
    }

    Text
    {
        anchors.fill: parent
        visible: metaData !== null
        text: MainJs.metaData2Text(metaData, 'title', 'datetaken')
    }
}
