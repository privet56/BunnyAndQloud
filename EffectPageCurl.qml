import QtQuick 2.5

Effect
{
    id: pageCurlEffect
    divider: false

    property real curlExtent: 1.0

    fragmentShaderFilename: "pagecurl.fsh"

    PropertyAnimation { property: "curlExtent"; duration: 3000; from:1.0; to:-0.2; running: true; loops: 1; target: pageCurlEffect }
}
