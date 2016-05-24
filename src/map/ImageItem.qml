import QtQuick 2.4
import QtQuick.Controls 1.3

import QtPositioning 5.3
import QtLocation 5.4

MapQuickItem    //to be used inside MapComponent only
{
    id: imageItem

    property variant userdata;
    property string imgSrc;
    property bool bigger;

    signal onItemDblClicked (var imgSrc, var userdata);

    MouseArea
    {
        anchors.fill: parent
        drag.target: parent

        onClicked:
        {
            bigger = !bigger;
            bImage.width = bigger  ? 66 : 66*2
            bImage.height = bigger ? 66 : 66*2
            bImageTitle.color = bigger ? "red" : "white"
        }
        onDoubleClicked:
        {
            onItemDblClicked(imgSrc, userdata);
            return;/*
            var page = Qt.resolvedUrl("../../BunnyImg.qml")
            page.src = imgSrc
            stackView.push(page, {src:imgSrc, metaData:userdata})
            titleBar.title = userdata.title*/
        }
    }

    function setGeometry(markers, index)
    {
        //console.log("lati:"+userdata.latitude+" longi:"+userdata.longitude+" img:"+userdata.url_m)

        coordinate.latitude = userdata.latitude
        coordinate.longitude = userdata.longitude

        //coordinate.latitude = markers[index].coordinate.latitude
        //coordinate.longitude = markers[index].coordinate.longitude
    }

    sourceItem: Image
    {
        id: bImage
        source: imgSrc
        opacity: 0.7
        width: 66
        height: 66
        Text
        {
            id: bImageTitle
            anchors.fill: parent
            visible: (userdata && userdata.title) ? true : false
            text: (userdata && userdata.title) ? userdata.title : ""
            color: "white"
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
