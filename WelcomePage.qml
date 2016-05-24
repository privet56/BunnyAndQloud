import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Particles 2.0

import "src/buttons"

import "src/variables/fontawesome.js" as FontAwesome

import "./js/main.js" as MainJs
import "./js/RegisterForm.js" as RegisterFormJs

Item
{
    width: parent.width
    height: parent.height

    Text
    {
        text: qsTr(" ")
        font.pixelSize: 25
    }

    Component.onCompleted:
    {
        welcomeTimer.restart()
    }

    Timer
    {
        id: welcomeTimer
        interval: 111
        repeat: false
        onTriggered:
        {
            console.log("welcomeTimer")
            var page = Qt.resolvedUrl("LoginForm.qml")
            stackView.push({item:page, immediate: true, replace: true})
            titleBar.title = "Bunny & Qlcoud"
        }
    }
}
