import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQml 2.2

import "src/lists"
import "src/bars"
import "src/buttons"
import "src/variables/fontawesome.js" as FontAwesome

import "./js/main.js" as MainJs
import "./js/BunnyCoverFlowJs.js" as BunnyCoverFlowJs

ApplicationWindow
{
    id: window
    title: "Bunny & Cloud"
    visible: true
    width: 600
    height: 800

    property string token: ""
    //property string operatingSystem: ""

    onClosing:
    {
        Qt.quit();
        //qmlHelper.quit();
    }

    FontLoader{ source: "qrc:/src/fonts/fontawesome-webfont.ttf"}

    Rectangle
    {
        anchors.fill: parent
    }

    toolBar: Bar
    {
        id: titleBar
        leftComponent: Component
        {
            ButtonDefault
            {
                class_name: "bar dark clear"
                text: "Back"
                icon: FontAwesome.icons.fa_angle_left
                opacity: stackView.depth > 1 ? 1 : 0
                visible: opacity ? true : false
                Behavior on opacity { NumberAnimation{} }
                onClicked:
                {
                    stackView.pop()
                    titleBar.title = "Bunny & Cloud"
                    MainJs.onPop(stackView);
                }
            }
        }

        rightComponent: Component
        {
            AnimatedImage
            {
                source: "res/bunny_hopps2.gif"
            }
        }

        class_name: "header positive"
        title: "Bunny & Cloud"
    }

    StackView
    {
        id: stackView
        anchors.fill: parent
        focus: true
        Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 1)
        {
            stackView.pop();
            event.accepted = true;
            MainJs.onPop(stackView);
        }

        //initialItem: WelcomePage { }
        initialItem: LoginForm { }
        //initialItem: BunniesNearby { }
        //initialItem: FunctionChooser { }
    }

    statusBar: Bar
    {
        height: 64
        radius: 15
        class_name: "assertive footer"
        color: "#f49494"
        border.color: "#828282"
        title: "Powered by the microservices of<br><a href='http://bunny-bunnyandcloud.rhcloud.com/'>http://bunny-bunnyandcloud.rhcloud.com/</a>"
        MouseArea
        {
            onClicked: qmlHelper.openUrl("http://bunny-bunnyandcloud.rhcloud.com/")
            anchors.fill: parent
        }
    }
//build cache!
    ListView
    {
        visible: false
        model: BunnyCoverFlowJs.bunnyImages()
        delegate: Image
        {
            visible: false
            source: modelData.src
            width: 11
            height: 11
            //onStatusChanged: if (status === Image.Ready) console.log("load finished...");
        }
    }

    /*
    Component.onCompleted:
    {
        t.restart()
    }
    Timer
    {
        id: t
        interval: 10
        repeat: false
        onTriggered:
        {
            console.log("t")
            stackView.push(Qt.resolvedUrl("LoginForm.qml"))
            titleBar.title = "Login"

        }
    }
    */
}
