import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Particles 2.0

import QtPositioning 5.5
import QtLocation 5.5

import "src/lists"
import "src/bars"
import "src/buttons"
import "src/map"
import "src/map/helper.js" as Helper

import "src/variables/fontawesome.js" as FontAwesome

import "./js/main.js" as MainJs
import "./js/BunniesNearby.js" as BunniesNearbyJs

Item
{
    id: bunniesNearbyRoot

    property variant map
    property variant mapCenter
    property variant minimap

    Binding
    {
        target: bunniesNearbyRoot
        property: "mapCenter"
        value: positionSource.position.coordinate
    }

    RestModel
    {
        id: restModel
        coordinate: bunniesNearbyRoot.mapCenter
    }

    Text
    {
        id: msgs
        width: parent.width
        height: text.length > 1 ? 29 : 0
        text: " "
    }

    function createMap(provider)
    {
        var plugin = Qt.createQmlObject ('import QtLocation 5.3; Plugin{ name:"' + provider + '"}', bunniesNearbyRoot)

        /*if (bunniesNearbyRoot.map) {
            bunniesNearbyRoot.map.destroy()
            bunniesNearbyRoot.map = null
            minimap = null
        }*/

        //bunniesNearbyRoot.map = mapComponent.createObject(bunniesNearbyRoot);
        bunniesNearbyRoot.map = mapComponent
        bunniesNearbyRoot.map.plugin = plugin;
        bunniesNearbyRoot.map.zoomLevel = (bunniesNearbyRoot.map.maximumZoomLevel - bunniesNearbyRoot.map.minimumZoomLevel)/2

        positionSource.active = true
        positionSource.update();

        console.log("createMapp: positionSource.active:'"+positionSource.active+"'")

        if(positionSource.supportedPositioningMethods === PositionSource.NoPositioningMethods)
        {
            msgs.text = (qsTr("Your System does not support or allow positioning"))
        }
        mapComponent.center = bunniesNearbyRoot.mapCenter;
        BunniesNearbyJs.search4Bunnies(mapComponent.center/*default: munich*/, mapComponent);
        //map.geocode('Munich Germany')
    }

    PositionSource
    {
        id: positionSource
        updateInterval: 10000
        active: true

        onPositionChanged:
        {
            console.log("onPositionChanged positionSource.active:'"+positionSource.active+"' coord:'"+position.coordinate+"' map: '"+mapComponent+"' <?> "+map)
            //if(bunniesNearbyRoot.map)bunniesNearbyRoot.map.center = position.coordinate    // center the map on the current position
            bunniesNearbyRoot.mapCenter = position.coordinate
            BunniesNearbyJs.search4Bunnies(bunniesNearbyRoot.mapCenter, mapComponent);
        }
    }

    Component.onCompleted:
    {
        createMap("osm");
    }

//    Component
//    {
//        id: mapComponent
        MapComponent
        {
            id: mapComponent
            //anchors.fill: parent
            width: bunniesNearbyRoot.width
            height: bunniesNearbyRoot.height - msgs.height
            anchors.top: msgs.bottom
            center: mapCenter
            //plugin: "osm"
            //onFollowmeChanged: mainMenu.isFollowMe = map.followme
            //onSupportedMapTypesChanged: mainMenu.mapTypeMenu.createMenu(map)
            onCoordinatesCaptured:
            {
                var text = "<b>" + qsTr("Latitude:") + "</b> " + Helper.roundNumber(latitude,4) + "<br/><b>" + qsTr("Longitude:") + "</b> " + Helper.roundNumber(longitude,4)
                msgs.text = (qsTr("Coordinates ") + text);
            }
            onGeocodeFinished:
            {
                if (map.geocodeModel.status === GeocodeModel.Ready)
                {
                    if (map.geocodeModel.count === 0)
                    {
                        msgs.text = (qsTr("Geocode Error ")+qsTr("Unsuccessful geocode"))
                    }
                    else if (map.geocodeModel.count > 1)
                    {
                        msgs.text = (qsTr("Ambiguous geocode ") +  map.geocodeModel.count + " " + qsTr("results found for the given address, please specify location"))
                    }
                    else
                    {
                        //msgs.text = (qsTr("Location") + geocodeMessage())
                    }
                }
                else if (map.geocodeModel.status === GeocodeModel.Error)
                {
                    msgs.text = (qsTr("Geocode Error ")+qsTr("Unsuccessful geocode"))
                }
            }
            onRouteError: msgs.text = (qsTr("Route Error ") + qsTr("Unable to find a route for the given points"))

            onShowGeocodeInfo: msgs.text = (qsTr("Location") + geocodeMessage())

            onErrorChanged:
            {
                if (map.error !== Map.NoError)
                {
                    var title = qsTr("ProviderError")
                    var message =  map.errorString + "<br/><br/><b>" + qsTr("Try to select other provider") + "</b>"
                    if (map.error === Map.MissingRequiredParameterError)
                        message += "<br/>" + qsTr("or see") + " \'mapviewer --help\' " + qsTr("how to pass plugin parameters.")
                    msgs.text = (title+" "+message);
                }
            }

            onShowMainMenu: mapPopupMenu.show(coordinate)
            onShowMarkerMenu: markerPopupMenu.show(coordinate)
            onShowRouteMenu: itemPopupMenu.show("Route",coordinate)
            onShowPointMenu: itemPopupMenu.show("Point",coordinate)
            onShowRouteList: stackView.showRouteListPage()
        }
//    }
/*
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
    }*/
}
