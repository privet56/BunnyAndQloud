import Qt3D.Core 2.0
import Qt3D.Render 2.0
import QtQuick 2.0

Entity {
    id: sceneRoot

    property real rotationX: 0
    property real rotationY: 0
    property real rotationZ: 0

    Camera {
        id: camera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 40
        aspectRatio: 4/3
        nearPlane : 0.1
        farPlane : 1000.0
        position: Qt.vector3d( 0.0, 0.0, 0.0 )
        upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
        viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
    }

    Configuration  {
        controlledCamera: camera
    }

    components: [
        FrameGraph {
            activeFrameGraph: ForwardRenderer {
                camera: camera
                clearColor: "green"
            }
        }
    ]

    PhongMaterial
    {
        id: material
        ambient: Qt.rgba( 122, 122, 122, 1.0 )
        diffuse: Qt.rgba( 0.1, 0.1, 0.1, 0.5 )
        shininess: 20.0
    }

    Transform {
        id: leaTransform
        rotation: fromEulerAngles( 0, 90, rotationZ )
    }

    Mesh {
        id: leaMesh
        source: "o/lea/lea.obj"
    }

    Entity {
        id: leaEntity
        components: [ leaMesh, material, leaTransform ]
    }
}
