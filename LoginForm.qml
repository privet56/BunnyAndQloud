import QtQuick 2.5
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Particles 2.0
//import QtQuick.Scene3D 2.0

//import Qt3D 2.0
//import Qt3D.Renderer 2.0

//import QtCanvas3D 1.0

//import QtWebKit 3.0
//import QtWebKit.experimental 1.0

//import QtWebEngine 1.0

import "src/buttons"
//import "3d"   //we do it with alias in the qrc

import "src/variables/fontawesome.js" as FontAwesome

import "./js/main.js" as MainJs
import "./js/LoginForm.js" as LoginFormJs
//import "./js/rabbit3dexplorer.js" as Rabbit3dexplorer

Item
{
    id: loginFormItem
    width: 400
    height: 400
    antialiasing: true

    onVisibleChanged:
    {
        //wv.url = visible ? qmlHelper.getAppDirAsUrl()+"/3d/3drabbitexplorer/3drabbitexplorer.html" : "about:blank";
        wvExpander.visible = visible ? true : false;
    }

//TODO: set to null
    //property string token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiYnVubnkiLCJ1c2VybmFtZSI6ImJ1bm55IiwiaWF0IjoxNDM2MjUyMzc0LCJleHAiOjE0MzYzMzg3NzR9.MUDlDRlFXBI0jvXLg4TSRt0HMfcVMazYhbT6_EnheZQ"
    property string token: ""

    FontLoader{ source: "qrc:/res/fonts/OLDENGL.TTF" }

    GridLayout
    {
        id: gridlayout
        y: 0

        transformOrigin: Item.Top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.rightMargin: 0
        anchors.leftMargin: 6

        columns: 2
        columnSpacing:4

        RowLayout
        {
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.columnSpan: 2
            Text
            {
                text: qsTr("  ")    //placeholder
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 11
                Layout.minimumWidth: 99
            }
        }
        RowLayout
        {
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.columnSpan: 2
            Text
            {
                text: qsTr("  Login ")
                font.family: "Old English Text MT"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 25
                Layout.minimumWidth: 99
            }
        }
        RowLayout
        {
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.columnSpan: 2

            Text
            {
                text: qsTr(" Username:  ")
                font.pixelSize: 16
                Layout.minimumWidth: 99
                //Layout.fillWidth: true
                //width: parent.width / 3
            }

            TextField
            {
                id: inputUsername
                anchors.right: parent.right
                font.pixelSize: 16
                anchors.rightMargin: 7
                Layout.fillWidth: true
                style: touchStyle
                onTextChanged: LoginFormJs.onTextFieldChanged()
            }
        }

        RowLayout
        {
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.columnSpan: 2

            Text
            {
                text: qsTr(" Password:  ")
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
                onTextChanged: LoginFormJs.onTextFieldChanged()
            }
        }

        ButtonDefault
        {
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            Layout.preferredWidth: 155
            width: 199
            height: 99

            enabled: false

            class_name: enabled ? "positive block" : "default stable"
            id: bLogin
            text: "Login!"
            Layout.columnSpan: 2
            anchors.horizontalCenter: parent.horizontalCenter


            //radius:9  //would work with 'normal' Rectangle's

            icon: FontAwesome.icons.fa_phone

            onClicked:
            {
                LoginFormJs.dologin()
            }

            /*style: ButtonStyle
            {
                background: Rectangle
                {
                    implicitWidth: 100
                    implicitHeight: 35
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888"
                    radius: 4
                    gradient: Gradient
                    {
                        GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                        GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#019fde" }
                    }
                }
            }*/
        }

        RowLayout
        {
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.columnSpan: 2
            Text
            {
                text: qsTr("  ")    //placeholder
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 16
                Layout.minimumWidth: 99
            }
        }

        ButtonDefault
        {
            Layout.preferredWidth: 155
            icon: FontAwesome.icons.fa_cog
            class_name: "energized"
            id: bRegister
            text: "Register..."
            Layout.columnSpan: 2
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked:
            {
                stackView.push(Qt.resolvedUrl("RegisterForm.qml"))
                titleBar.title = "Register"
            }
        }

        RowLayout
        {
            id: bunnyrowlayout
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.columnSpan: 2

            AnimatedImage
            {
                anchors.horizontalCenter: parent.horizontalCenter
                source: qmlHelper.getOS() === "android" ? "res/bunny.png" : "res/bunny_hopps2.gif"
                id: vaiwyBunny
                width: 160; height: width
                smooth: true

                //opacity: 0
                visible: !vaiwyBunnyShaderEffect.visible

                //Component.onCompleted: vawiTimer.restart()

                /*transform:            //works!
                [
                    Rotation
                    {
                        origin.x: parent.width / 2
                        origin.y: parent.height / 2
                        axis { x: 1; y: 0; z: 0 }
                        angle: 33
                        Behavior on angle
                        {
                            SpringAnimation
                            {
                                spring: 1.5; damping: 0.75
                            }
                        }
                    },
                    Rotation
                    {
                        origin.x: parent.width / 2
                        origin.y: parent.height / 2
                        axis { x: 0; y: 1; z: 0 }
                        angle: 33
                        Behavior on angle
                        {
                            SpringAnimation
                            {
                                spring: 1.5; damping: 0.75
                            }
                        }
                    }
                ]*/
            }

            ShaderEffect
            {
                id: vaiwyBunnyShaderEffect
                width: 160; height: width
                property variant src: vaiwyBunny
                property variant source: vaiwyBunny
                property real frequency: 8.0
                property real amplitude: 0.02
                property real time: 0.01
                blending: true
                visible: qmlHelper.getOS() !== "android"        //grrrr, ShaderEffect does not work on Qt5.5 without Ministro (but with Qt5.4 + Ministro is ok)
                onStatusChanged:
                {
                    console.log("shaderStatus:"+status+" log:'"+log+"' (status==ok would be 0)")
                }
                /*Component.onCompleted: console.log("shaderEffect:onCompleted: log:'"+log+"' status:"+status+" (compiledStatus="+ShaderEffect.Compiled+", errorStatus:"+ShaderEffect.Error+")")
                onStatusChanged:
                {
                    console.log("shaderEffect:onStatusChanged: log:'"+log+"' status:"+status+" os:"+qmlHelper.getOS()+" visible:"+visible+" vaiwyBunny.visible:"+vaiwyBunny.visible)
                    visible = (qmlHelper.getOS() === "windows" && status == ShaderEffect.Error) ? false : true;
                    console.log("shaderEffect:onStatusChanged: log:'"+log+"' status:"+status+" os:"+qmlHelper.getOS()+" visible:"+visible+" vaiwyBunny.visible:"+vaiwyBunny.visible)
                    vaiwyBunny.visible = !visible;
                }
                Timer
                {
                    repeat: true
                    interval: 1000
                    running: true
                    onTriggered:
                    {
                        console.log("shaderEffect:timer: log:'"+parent.log+"' status:"+parent.status+" os:"+qmlHelper.getOS()+" visible:"+parent.visible+" vaiwyBunny.visible:"+vaiwyBunny.visible)
                        vaiwyBunny.visible = !visible;
                    }
                }*/

                NumberAnimation on time
                {
                    from: 001; to: Math.PI*2; duration: 1000; loops: Animation.Infinite
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

    /*Canvas3D  !.obj
    {
        id: canvas3d
        width: parent.width
        anchors.top: gridlayout.bottom
        anchors.bottom: parent.bottom
        focus: true

        onInitializeGL:
        {
            Rabbit3dexplorer.initializeGL(canvas3d, eventSource, canvas3d);
        }

        onPaintGL:
        {
            Rabbit3dexplorer.paintGL(canvas3d);
            //fpsDisplay.fps = canvas3d.fps;
        }

        onResizeGL:
        {
            Rabbit3dexplorer.onResizeGL(canvas3d);
        }

        ControlEventSource
        {
            anchors.fill: parent
            focus: true
            id: eventSource
        }
    }* /
    Scene3D     !.obj+mtl
    {
        id:scene3Dwrapper
        width: parent.width
        anchors.top: gridlayout.bottom
        anchors.bottom: parent.bottom
        focus: true
        aspects: "input"
        Scene
        {
            id: scene3D
        }
    }
    */
    /*WebView   //!webgl
    {
        id: webview
        url: "file:///e:/svn/sen-soa/trunk/sandbox/ghe/bunnyandqloud/build-bunnyandqloud_qq-5_5_desktop_64bit-Release/release/3d/3drabbitexplorer/3drabbitexplorer.html"
        width: parent.width
        anchors.top: gridlayout.bottom
        anchors.bottom: parent.bottom
        experimental.preferences.javascriptEnabled: true
        experimental.preferences.fileAccessFromFileURLsAllowed: true
        experimental.preferences.universalAccessFromFileURLsAllowed: true
        experimental.preferences.navigatorQtObjectEnabled: true
        experimental.preferences.autoLoadImages: true
        experimental.preferences.offlineWebApplicationCacheEnabled: true
        experimental.preferences.pluginsEnabled: true
        experimental.preferences.webAudioEnabled: true
        experimental.preferences.webGLEnabled: true
        experimental.preferences.developerExtrasEnabled: true
        experimental.onMessageReceived: {
            console.log(message.data);
        }

        onLoadingChanged:
        {
             //if (!loading && loadRequest.status == WebView.LoadFailedStatus)
                 console.log("status:"+loadRequest.status+" eCode: "+loadRequest.errorCode+"(="+loadRequest.errorString+") url:"+loadRequest.url)
        }
    }*/
    /*
    WebEngineView
    {
        id: wv
        AnimatedImage
        {
            id: wvExpander
            visible: parent.visible
            z: parent.z + 1
            anchors.top: parent.top
            anchors.right: parent.right
            source: "res/expand.gif"
            width: 32; height: width
            smooth: true
            MouseArea
            {
                anchors.fill: parent
                onClicked: LoginFormJs.on3DBunnyExplorerClick(parent.parent, parent)
            }
        }
        visible: qmlHelper.getOS() !== "android"
        url: "about:blank"
        width: parent.width
        anchors.top: gridlayout.bottom
        anchors.bottom: parent.bottom
    }*/

    C3d
    {
        id: canvas3d

        AnimatedImage
        {
            id: wvExpander
            visible: parent.visible
            z: parent.z + 1
            anchors.top: parent.top
            anchors.right: parent.right
            source: "res/expand.gif"
            width: 32; height: width
            smooth: true
            MouseArea
            {
                anchors.fill: parent
                onClicked: LoginFormJs.on3DBunnyExplorerClick(parent.parent, parent)
            }
        }

        width: parent.width
        anchors.top: gridlayout.bottom
        anchors.bottom: parent.bottom
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

//particles

    ParticleSystem
    {
        id: particleSystem
    }

    ImageParticle
    {
        source: "images/ps_ball.png"
        system: particleSystem
        color: '#FFD700'
        colorVariation: 0.6
        rotation: 0
        rotationVariation: 45
        rotationVelocity: 15
        rotationVelocityVariation: 15
        entryEffect: ImageParticle.Scale
    }
    Emitter
    {
        id: emitter
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        width: 1; height: 1
        system: particleSystem
        emitRate: 0.6
        lifeSpan: 6400
        lifeSpanVariation: 400
        size: 16
        velocity: AngleDirection
        {
            angle: -45
            angleVariation: 0
            magnitude: 100
        }
        acceleration: AngleDirection
        {
            angle: 70
            magnitude: 25
        }
    }

    Turbulence
    {
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width / 2; height: parent.height
        system: particleSystem
        strength: 10000
    }

    CurtainEffect
    {
        id: curtain
        anchors.fill: parent
        open: false
    }

    Timer
    {
        id: curtainTimer
        interval: 100
        repeat: false
        onTriggered:
        {
            curtain.open = true
            console.log("timer ... curtain.open:"+curtain.open)
        }
    }

    Component.onCompleted:
    {
        curtainTimer.restart();
        //wv.url = qmlHelper.getAppDirAsUrl()+"/3d/3drabbitexplorer/3drabbitexplorer.html";
    }
}
