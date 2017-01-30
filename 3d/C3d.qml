import QtQuick 2.6
import QtCanvas3D 1.1

import "c3d.js" as GLCode

Canvas3D {
    id: canvas3d
    property double xRotAnim: 0
    property double yRotAnim: 0
    property double zRotAnim: 0
    property double rotateDistance: 2
    property double uiDistance: 1.51 // This distance is selected so that UI on model matches the size of QML UI
    property double distance: rotateDistance
    property double cameraAngle: 0
    property Item textureSource
    signal rotationStopped
    signal rotationStarted

    Component.onCompleted: {
        GLCode.setSphereTexture("qrc:/back.jpg")
    }
    //! [1]
    onInitializeGL:
    {
        GLCode.isAndroid = qmlHelper.getOS() === 'android';
        GLCode.initializeGL(canvas3d, textureSource)
    }
    //! [1]
    onPaintGL: GLCode.paintGL(canvas3d)
    onResizeGL: GLCode.resizeGL(canvas3d)

    state: "running"
    states: [
        State {
            name: "running"
            StateChangeScript {
                script: {
                    resetAnimationX.stop()
                    resetAnimationY.stop()
                    resetAnimationZ.stop()
                    resetAnimationDistance.stop()
                    resetAnimationDistance.duration = 2000
                    resetAnimationDistance.from = canvas3d.distance
                    resetAnimationDistance.to = canvas3d.rotateDistance
                    resetAnimationDistance.start()
                    objAnimationX.start()
                    objAnimationY.start()
                    objAnimationZ.start()
                    rotationStarted()
                }
            }
        },
        State {
            name: "stopped"
            StateChangeScript {
                script: {
                    objAnimationX.stop()
                    objAnimationY.stop()
                    objAnimationZ.stop()
                    resetAnimationDistance.stop()
                    resetAnimationX.from = canvas3d.xRotAnim
                    resetAnimationY.from = canvas3d.yRotAnim
                    resetAnimationZ.from = canvas3d.zRotAnim
                    resetAnimationDistance.duration = resetAnimationX.duration
                    resetAnimationDistance.from = canvas3d.distance
                    resetAnimationDistance.to = canvas3d.uiDistance
                    resetAnimationDistance.start()
                    resetAnimationX.start()
                    resetAnimationY.start()
                    resetAnimationZ.start()
                    rotationStopped()
                }
            }
        }
    ]

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (canvas3d.state === "stopped")
                canvas3d.state = "running"
            else
                canvas3d.state = "stopped"
        }
    }

    SequentialAnimation {
        id: objAnimationX
        loops: Animation.Infinite
        running: true
        NumberAnimation {
            target: canvas3d
            property: "xRotAnim"
            from: -90.0
            to: 270.0
            duration: 9200
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: canvas3d
            property: "xRotAnim"
            from: 270.0
            to: -90.0
            duration: 9200
            easing.type: Easing.InOutQuad
        }
    }

    SequentialAnimation {
        id: objAnimationY
        loops: Animation.Infinite
        running: true
        NumberAnimation {
            target: canvas3d
            property: "yRotAnim"
            from: 0.0
            to: 360.0
            duration: 8500
            easing.type: Easing.InOutCubic
        }
        NumberAnimation {
            target: canvas3d
            property: "yRotAnim"
            from: 360.0
            to: 0.0
            duration: 8500
            easing.type: Easing.InOutCubic
        }
    }

    SequentialAnimation {
        id: objAnimationZ
        loops: Animation.Infinite
        running: true
        NumberAnimation {
            target: canvas3d
            property: "zRotAnim"
            from: 180.0
            to: -180.0
            duration: 7600
            easing.type: Easing.InOutSine
        }
        NumberAnimation {
            target: canvas3d
            property: "zRotAnim"
            from: -180.0
            to: 180.0
            duration: 7600
            easing.type: Easing.InOutSine
        }
    }

    NumberAnimation {
        id: resetAnimationX
        running: false
        loops: 1
        target: canvas3d
        property: "xRotAnim"
        from: 0.0
        to: -90.0
        duration: 600
        easing.type: Easing.InOutSine
    }
    NumberAnimation {
        id: resetAnimationY
        running: false
        loops: 1
        target: canvas3d
        property: "yRotAnim"
        from: 0.0
        to: 0.0
        duration: resetAnimationX.duration
        easing.type: Easing.InOutSine
    }
    NumberAnimation {
        id: resetAnimationZ
        running: false
        loops: 1
        target: canvas3d
        property: "zRotAnim"
        from: 0.0
        to: 180.0
        duration: resetAnimationX.duration
        easing.type: Easing.InOutSine
    }
    NumberAnimation {
        id: resetAnimationDistance
        running: false
        loops: 1
        target: canvas3d
        property: "distance"
        from: canvas3d.rotateDistance
        to: canvas3d.uiDistance
        duration: resetAnimationX.duration
        easing.type: Easing.InOutSine
    }
    RotationAnimation {
        id: cameraRotationAnimation
        running: true
        target: canvas3d
        property: "cameraAngle"
        loops: Animation.Infinite
        from: 0
        to: 360
        duration: 60000
        direction: RotationAnimation.Clockwise
    }
}
