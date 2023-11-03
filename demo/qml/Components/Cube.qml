
import QtQuick 6.6
import QtQuick3D 6.6
import Qt3D.Input 2.6

import Theme 1.0

View3D {
    id: view

    PerspectiveCamera {
        id: camera
        position: Qt.vector3d(0, 80, 120)
        eulerRotation.x: -30
        fieldOfView: 90
    }

    DirectionalLight {
        eulerRotation.x: -30
    }

    MouseArea {
        anchors.fill: parent

        property real pressedX
        property real pressedY

        onWheel: (wheel) => { zoom(wheel.angleDelta.y * 0.05) }

        onMouseXChanged: Qt.callLater(update)
        
        onMouseYChanged: Qt.callLater(update)

        onPressed: [pressedX,pressedY] = [mouseX,mouseY]

        function update() {
            let [dx,dy] = [mouseX - pressedX,mouseY - pressedY];
            [pressedX,pressedY] = [mouseX,mouseY];
            cube.rotate(dx, Qt.vector3d(0, 1, 0), Node.SceneSpace);
            cube.rotate(dy, Qt.vector3d(1, 0, 0), Node.SceneSpace);
        }

        function zoom(delta)
        {
            if (camera.position.z + delta < 50 || camera.position.z + delta > 500)
                return
            camera.position = camera.position.plus(Qt.vector3d(0,0,delta))
        }
    }

    Node {
        id: cube
        Model {
            source: "#Cube"
            materials: DefaultMaterial {
                diffuseMap: Texture {
                    sourceItem: Rectangle {
                        color: Theme.color.secondary800
                        width: 1024
                        height: width
                        Image {
                            sourceSize: Qt.size(parent.width, parent.width)
                            source: "qrc:/assets/icons/demo.svg"
                        }
                    }
                }
            }

            Vector3dAnimation on eulerRotation {
                loops: Animation.Infinite
                duration: 5000
                from: Qt.vector3d(0, 0, 0)
                to: Qt.vector3d(360, 0, 360)
            }
        }
    }
}