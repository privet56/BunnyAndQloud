import QtQuick 2.5
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Particles 2.0
import QtMultimedia 5.5

import "src/lists"
import "src/bars"
import "src/buttons"

import "src/variables/fontawesome.js" as FontAwesome

import "./js/main.js" as MainJs

Rectangle
{
    id: bunnyVideo
    property string effectSource
    color: "black"

    VideoOutput
    {
        id: root4VideoOutput
        height: width
        source: mediaPlayer

        property int rot: 9

        property alias duration: mediaPlayer.duration
        property alias mediaSource: mediaPlayer.source
        property alias metaData: mediaPlayer.metaData
        property alias playbackRate: mediaPlayer.playbackRate
        property alias position: mediaPlayer.position
        property alias volume: mediaPlayer.volume

        signal sizeChanged
        signal fatalError

        onHeightChanged: root4VideoOutput.sizeChanged()

        MediaPlayer
        {
            id: mediaPlayer
            autoPlay: true
            playbackRate: 0.5
            loops: MediaPlayer.Infinite
            autoLoad: true
            muted: true
            source: resServer.unpack(":/res/dwarf.rabbit.02.mp4")                               //qrc freezes on win!?
            //source: "http://bunny-bunnyandcloud.rhcloud.com/assets/dwarf.rabbit.02.mov"       //works too!
            //onPositionChanged: {console.log(position+" from src:"+source)}
            onError:
            {
                if (MediaPlayer.NoError != error)
                {
                    console.log("[qmlvideo] VideoItem.onError error " + error + " errorString " + errorString)
                    //root.fatalError()
                }
            }
        }

        function start() { mediaPlayer.play() }
        function stop() { mediaPlayer.stop() }
        function seek(position) { mediaPlayer.seek(position); }

        SequentialAnimation
        {
            loops: Animation.Infinite; running: true
            PropertyAnimation { property: "rotation"; duration: 3000; from:-root4VideoOutput.rot; to:root4VideoOutput.rot; target: root4VideoOutput }
            PropertyAnimation { property: "rotation"; duration: 3000; from:root4VideoOutput.rot; to:-root4VideoOutput.rot; target: root4VideoOutput }
        }
        MouseArea
        {
            anchors.fill: parent
            drag.target: parent
            drag.axis: Drag.XandYAxis
            onClicked:
            {
                if( root4VideoOutput.width > (window.width * 5))
                {
                    //...too big
                }
                else
                {
                    root4VideoOutput.width  += 111
                    root4VideoOutput.height += 111
                }
            }
        }

        Loader
        {
            id: effectLoader
            source: effectSource
        }

        ShaderEffectSource {
            id: theSource
            smooth: true
            hideSource: true
        }

        Component.onCompleted:
        {
            var applyEffect2 = stackView
            effectSource = "EffectPageCurl.qml"
            effectLoader.source = "EffectPageCurl.qml"
            effectLoader.item.parent = applyEffect2
            effectLoader.item.targetWidth = applyEffect2.width
            effectLoader.item.targetHeight = applyEffect2.height
            effectLoader.item.anchors.fill = applyEffect2
            effectLoader.item.source = theSource
        }
    }
    SeekControl
    {
        anchors
        {
            left: parent.left
            right: parent.right
            margins: 10
            bottom: parent.bottom
        }
        duration: root4VideoOutput.duration
        playPosition: root4VideoOutput.position
        onSeekPositionChanged: root4VideoOutput.seek(seekPosition);
    }
}

/*Rectangle
{
    width: parent.width
    height: parent.height
    anchors.topMargin: 20
    color: "black"

    MediaPlayer
    {
        id: player
        source: "res/dwarf.rabbit.02.mp4"
        //source: "http://bunny-bunnyandcloud.rhcloud.com/assets/dwarf.rabbit.02.MOV"
        autoPlay: true
        loops: MediaPlayer.Infinite
        autoLoad: true
        muted: true

        onAvailabilityChanged: console.log("availabilitychanged: "+availability)
        onError: console.log("error: "+error+" str:"+errorString)
        onErrorChanged: console.log("errorChanged: "+error+" str:"+errorString)
        onPlaybackStateChanged: console.log("PlaybackStateChanged: "+playbackState)
        onStatusChanged:
        {
            console.log("statusChanged: "+status+" (endIs:"+MediaPlayer.EndOfMedia+")")  //2,3,6
            //if(status == MediaPlayer.Buffered)play();
        }
        onStopped:
        {
            console.log("stopped")
            play()
        }
    }

    VideoOutput
    {
        id: videoOutput
        source: player
        anchors.fill: parent
    }
    MouseArea
    {
        id: playArea
        anchors.fill: parent
        onPressed:
        {
            console.log("pos:"+player.position);
            player.seek(0);
            player.play()
        }
    }
}

/*
import QtWebKit 3.0
WebView
{
    width: parent.width
    height: parent.height
    anchors.topMargin: 20

   id: webView
   opacity: 0

   url: "src/player.html?c_Ns7_wEsyo"

   Behavior on opacity { NumberAnimation { duration: 200 } }

   onLoadingChanged:
   {
       switch (loadRequest.status)
       {
       case WebView.LoadSucceededStatus:
           opacity = 1
           return
       case WebView.LoadStartedStatus:
       case WebView.LoadStoppedStatus:
           break
       case WebView.LoadFailedStatus:
           console.log("Failed to load the requested video")
           break
       }
       opacity = 0
   }
   onTitleChanged:
   {
       if(title.length > 3)
            titleBar.title = title
   }
}
*/
