import QtQuick 2.0
import QtQuick.XmlListModel 2.0

import "./js/BunniesNearby.js" as BunniesNearbyJs

XmlListModel
{
    property variant coordinate

    source: BunniesNearbyJs.search4Bunnies(coordinate)

    query: "/rsp/photos/photo"

    XmlRole { name: "title"; query: "@title/string()" }
    XmlRole { name: "datetaken"; query: "@datetaken/string()" }
    XmlRole { name: "farm"; query: "@farm/string()" }
    XmlRole { name: "server"; query: "@server/string()" }
    XmlRole { name: "id"; query: "@id/string()" }
    XmlRole { name: "secret"; query: "@secret/string()" }
}
