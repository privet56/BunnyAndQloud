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
    id: registerFormItem
    width: 400
    height: 400
    antialiasing: true

    FontLoader{ source: "qrc:/res/fonts/OLDENGL.TTF" }

    GridLayout
    {
        y: 0

        transformOrigin: Item.Top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.rightMargin: 0
        anchors.leftMargin: 6

        columns: 2
        columnSpacing: 4

        Text
        {
            text: qsTr("  Register ")
            font.family: "Old English Text MT"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 25
            Layout.minimumWidth: 99
        }
        Text
        {
            text: qsTr(" ")
            font.family: "Old English Text MT"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 25
            Layout.minimumWidth: 99
        }

        Text
        {
            text: qsTr(" Name: ")
            font.pixelSize: 16
            width: 199
        }

        TextField
        {
            id: inputName
            anchors.right: parent.right
            font.pixelSize: 16
            anchors.rightMargin: 7
            Layout.fillWidth: true
            style: touchStyle
            onTextChanged: RegisterFormJs.onTextFieldChanged()
        }

        Text
        {
            text: qsTr(" Username: ")
            font.pixelSize: 16
            width: 199
        }

        TextField
        {
            id: inputUsername
            anchors.right: parent.right
            font.pixelSize: 16
            anchors.rightMargin: 7
            Layout.fillWidth: true
            style: touchStyle
            onTextChanged: RegisterFormJs.onTextFieldChanged()
        }

        Text
        {
            text: qsTr(" Password:           ")
            font.pixelSize: 16
            Layout.minimumWidth: 99
        }

        TextField
        {
            id: inputPassword
            anchors.right: parent.right
            font.pixelSize: 16
            anchors.rightMargin: 8
            Layout.fillWidth: true
            echoMode: TextInput.PasswordEchoOnEdit//TextInput.Password
            //passwordCharacter: '♥'
            style: touchStyle
            onTextChanged: RegisterFormJs.onTextFieldChanged()
        }

        Text
        {
            text: qsTr(" Retype password:  ")
            font.pixelSize: 16
            Layout.minimumWidth: 99
        }

        TextField
        {
            id: inputPasswordRetype
            anchors.right: parent.right
            font.pixelSize: 16
            anchors.rightMargin: 8
            Layout.fillWidth: true
            echoMode: TextInput.PasswordEchoOnEdit//TextInput.Password
            //passwordCharacter: '♥'
            style: touchStyle
            onTextChanged: RegisterFormJs.onTextFieldChanged()
        }

        Text
        {
            id: hint
            color: "red"
            text: qsTr(" ")
            font.pixelSize: 12
            Layout.minimumWidth: 99
        }

        ButtonDefault
        {
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            Layout.preferredWidth: 155

            class_name: "energized"
            id: bRegister
            text: "Register!"
            Layout.columnSpan: 2
            anchors.horizontalCenter: parent.horizontalCenter
            enabled: false

            icon: FontAwesome.icons.fa_cog

            onClicked:
            {
                RegisterFormJs.doregister()
            }
        }

        RowLayout
        {
            id: bunnyrowlayout
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.columnSpan: 2
            Image
            {
                anchors.horizontalCenter: parent.horizontalCenter
                source: "res/bunny.png"
                id: bunny
                visible: !vaiwyBunnyShaderEffect4Register.visible
            }
            ShaderEffect
            {
                id: vaiwyBunnyShaderEffect4Register
                width: 160; height: width
                property variant source: bunny
                property real frequency: 8
                property real amplitude: 0.08
                property real time: 0.0
                visible: qmlHelper.getOS() !== "android"        //grrrr, ShaderEffect does not work on Qt5.5 without Ministro (but with Qt5.4 + Ministro is ok)
                NumberAnimation on time
                {
                    from: 0; to: Math.PI*2; duration: 1000; loops: Animation.Infinite
                }
                fragmentShader: "
                varying highp vec2 qt_TexCoord0;
                uniform sampler2D source;
                uniform lowp float qt_Opacity;
                uniform highp float frequency;
                uniform highp float amplitude;
                uniform highp float time;
                void main()
                {
                    highp vec2 pulse = sin(time - frequency * qt_TexCoord0);
                    highp vec2 coord = qt_TexCoord0 + amplitude * vec2(pulse.x, -pulse.x);
                    gl_FragColor = texture2D(source, coord) * qt_Opacity;
                }"
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

    RotationAnimation
    {
        id: ani
        from: 0
        to: 360
        running: false
        duration: 1000
        loops: Animation.Infinite
    }

    Component
    {
        id: touchStyle

        TextFieldStyle
        {
            textColor: "blue"
            //font.pixelSize: 50
            background: Item
            {
                implicitHeight: 25
                implicitWidth: 675
                BorderImage
                {
                    source: "images/textinput.png"
                    border.left: 8
                    border.right: 8
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                }
            }
        }
    }
}
