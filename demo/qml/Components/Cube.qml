import QtQuick 6.6
import QtQuick3D 6.6

import Theme 1.0

View3D {
    id: view

    PerspectiveCamera {
        position: Qt.vector3d(0, 80, 120)
        eulerRotation.x: -30
        fieldOfView: 90
    }

    DirectionalLight {
        eulerRotation.x: -30
    }

    Model {
        id: cube
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