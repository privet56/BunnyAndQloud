import QtQuick 2.4
import QtQuick.Controls 1.3

import QtPositioning 5.3
import QtLocation 5.4

Rectangle{
    id: miniMapRect
    width: 152
    height: 152
    anchors.right: (parent) ? parent.right : undefined
    anchors.rightMargin: 10
    anchors.top: (parent) ? parent.top : undefined
    anchors.topMargin: 10
    color: "#242424"
    Map {
        id: miniMap
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.left: parent.left
        anchors.leftMargin: 1
        width: 150
        height: 150
        zoomLevel: (map.zoomLevel > minimumZoomLevel + 3) ? minimumZoomLevel + 3 : 2.5
        center: map.center
        plugin: map.plugin
        gesture.enabled: false

        MapRectangle {
            color: "#44ff0000"
            border.width: 1
            border.color: "red"
            topLeft {
                latitude: miniMap.center.latitude + 5
                longitude: miniMap.center.longitude - 5
            }
            bottomRight {
                latitude: miniMap.center.latitude - 5
                longitude: miniMap.center.longitude + 5
            }
        }
    }
}
