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
import "./js/Comments.js" as CommentsJs

Item
{
    width: parent.width
    height: parent.height
    id: commentsList
    anchors.topMargin: 20

    FontLoader{ source: "qrc:/res/fonts/OLDENGL.TTF" }

    property string token: window.token

    ListModel
    {
        id: pageModel
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
            //Layout.columnSpan: 2

            Text
            {
                text: qsTr("  Comments: ")
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
            AnimatedImage
            {
                Layout.alignment: Qt.AlignRight
                id: wait
                source: "qrc:/res/wait.gif"
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

                focus: true
                clip: true

                onItemClicked:
                {
                    //stackView.push(Qt.resolvedUrl(item.page))
                    //titleBar.title = item.title
                }
            }
        }
    }

    Component.onCompleted:
    {
        CommentsJs.getComments(token, pageModel)
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
