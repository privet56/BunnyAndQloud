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

Item
{
    width: parent.width
    height: parent.height
    id: functionChooser
    anchors.topMargin: 20

    FontLoader{ source: "qrc:/res/fonts/OLDENGL.TTF" }

    property string token: window.token

    ListModel
    {
        id: pageModel
        ListElement
        {
            avatar: "../../res/bunny.png"
            title: "The Bunnies"
            detail: "The Bunny pictures in a CoverFlow"
            page: "BunnyCoverFlow.qml"
        }
        ListElement
        {
            avatar: "../../res/user_blue.png"
            title: "The Fans"
            detail: "The Fan list"
            page: "Fans.qml"
        }
        ListElement
        {
            avatar: "../../res/comments.large.png"
            title: "Comments"
            detail: "The Comments of the Fans"
            page: "Comments.qml"
        }
        ListElement
        {
            avatar: "../../res/map.png"
            title: "Bunnies nearby"
            detail: "Find bunny releated activities nearby"
            page: "BunniesNearby.qml"
        }
        ListElement
        {
            avatar: "../../res/vid.png"
            title: "Bunny video - crossing the creek"
            detail: "Play a short video about a fearless Bunny crossing a creek\n(in slow motion = playback rate is 0.5)"
            page: "BunnyVideo.qml"
        }
        ListElement
        {
            avatar: "../../res/3d.png"
            title: "Bunny 3D Explorer"
            detail: "Explore the bunnies in 3D from every side by navigating with the mouse"
            page: "Bunny3DExplorer.qml"
        }
    }

    GridLayout
    {
        y: 0

        transformOrigin: Item.Top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.rightMargin: 0
        anchors.leftMargin: 6

        anchors.fill: parent

        columns: 2
        columnSpacing:4

        RowLayout
        {
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.columnSpan: 2

            Text
            {
                text: qsTr("  Functions: ")
                font.family: "Old English Text MT"
                font.pixelSize: 25
                Layout.fillWidth: true
                Layout.minimumWidth: 99
                Layout.preferredWidth: 40
                Layout.preferredHeight: 40
                Layout.alignment: Qt.AlignTop
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                anchors.topMargin: 9
                anchors.bottomMargin: 9
            }
        }
        RowLayout
        {
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.columnSpan: 2

            ThumbnailListView
            {
                model: pageModel
                anchors.right: parent.right
                anchors.fill: parent
                Layout.fillHeight: true
                Layout.fillWidth: true

                Layout.minimumWidth: 99
                Layout.preferredWidth: 40
                Layout.preferredHeight: 40
                Layout.alignment: Qt.AlignTop

                onItemClicked:
                {
                    stackView.push(Qt.resolvedUrl(item.page))
                    titleBar.title = item.title
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
