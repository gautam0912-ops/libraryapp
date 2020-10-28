import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    width: 600
    height: 400

    id: listpage
    title: qsTr("Home Page")
    property string totalbooks: '0'
    property string totalrentedbooks: '0'

    Rectangle {
        anchors.fill: parent

        Rectangle {
            x: 20
            y: 50
            width: parent.width

            Text {
                text: "Welcome to the library application!!"
                anchors.fill: parent
                font {
                    pixelSize: 30
                    bold: true
                }
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Rectangle {
            x: 20
            y: 110
            width: parent.width
            Text {
                anchors.fill: parent
                text: "Total number of books is " + totalbooks
                font {
                    pixelSize: 30
                    bold: true
                }
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Rectangle {
            x: 20
            y: 160
            width: parent.width

            Text {
                anchors.fill: parent

                text: "Total number of rentals is " + totalrentedbooks
                font {
                    pixelSize: 30
                    bold: true
                }
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
}
