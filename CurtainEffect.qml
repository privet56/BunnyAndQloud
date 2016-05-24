import QtQuick 2.0

ShaderEffect
{
    anchors.fill: parent

    mesh: GridMesh
    {
        resolution: Qt.size(50, 50)
    }

    property real topWidth: open ? width : 20
    property real bottomWidth: topWidth
    property real amplitude: 0.1
    property bool open: false
    property variant source: effectSource

    Behavior on bottomWidth
    {
        SpringAnimation
        {
            easing.type: Easing.OutElastic;
            velocity: 250; mass: 1.5;
            spring: 0.5; damping: 0.05
        }
    }

    Behavior on topWidth
    {
        NumberAnimation { duration: 100 }
    }

    ShaderEffectSource
    {
        id: effectSource
        sourceItem: effectImage;
        hideSource: true
    }

    Image
    {
        id: effectImage
        anchors.fill: parent
        source: "images/fabric.jpg"
        fillMode: Image.Tile
    }

    MouseArea
    {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        width: parent.topWidth

        onClicked:
        {
            curtain.open = !curtain.open
        }
    }

    property string sVertexShader: "
        attribute highp vec4 qt_Vertex;
        attribute highp vec2 qt_MultiTexCoord0;
        uniform highp mat4 qt_Matrix;
        varying highp vec2 qt_TexCoord0;
        varying lowp float shade;

        uniform highp float topWidth;
        uniform highp float bottomWidth;
        uniform highp float width;
        uniform highp float height;
        uniform highp float amplitude;

        void main() {
            qt_TexCoord0 = qt_MultiTexCoord0;

            highp vec4 shift = vec4(0.0, 0.0, 0.0, 0.0);
            highp float swing = (topWidth - bottomWidth) * (qt_Vertex.y / height);
            shift.x = qt_Vertex.x * (width - topWidth + swing) / width;

            shade = sin(21.9911486 * qt_Vertex.x / width);
            shift.y = amplitude * (width - topWidth + swing) * shade;

            gl_Position = qt_Matrix * (qt_Vertex - shift);

            shade = 0.2 * (2.0 - shade ) * ((width - topWidth + swing) / width);
        }"

    property string sFragmentShader: "
        uniform sampler2D source;
        varying highp vec2 qt_TexCoord0;
        varying lowp float shade;
        void main() {
            highp vec4 color = texture2D(source, qt_TexCoord0);
            color.rgb *= 1.0 - shade;
            gl_FragColor = color;
        }"

    vertexShader: sVertexShader
    fragmentShader: sFragmentShader

    /*Component.onCompleted:
    {
        shaderTimer.restart()
    }

    Timer
    {
        id: shaderTimer
        interval: 11
        repeat: false
        onTriggered:
        {
            //console.log("shaderTimer")
            //parent.vertexShader = parent.sVertexShader
            //parent.fragmentShader = parent.sFragmentShader
        }
    }*/
}
