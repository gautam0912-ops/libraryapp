import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    width: 600
    height: 400

    id: listpage
    title: qsTr("User List")
    property alias userlistmodel: userlistmodel
    property alias userlistview: userlistview
    property alias listmousearea: listmousearea

    //property alias mousearea1: mousearea1
    ListView {
        id: userlistview
        x: 70
        y: 30
        width: 400
        height: 160
        highlightRangeMode: ListView.NoHighlightRange

        model: ListModel {
            id: userlistmodel
        }
        highlight: Rectangle {
            color: "silver"
        }

        MouseArea {
            id: listmousearea
            propagateComposedEvents: true
            anchors.fill: parent
        }

        header: Item {
            x: 5
            height: 40
            width: 300
            Row {
                spacing: 10

                Rectangle {
                    width: 100
                    id: hcol1
                    anchors.left: parent.left
                    Text {
                        text: "FIRSTNAME"
                        anchors.fill: parent
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }
                }
                Rectangle {
                    anchors.left: hcol1.right
                    width: 100
                    id: hcol2
                    Text {
                        text: "LASTNAME"
                        anchors.fill: parent
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }
                }
                Rectangle {
                    anchors.left: hcol2.right
                    width: 100
                    id: hcol3
                    Text {
                        text: "DATECREATED"
                        anchors.fill: parent
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }
                }
            }
        }

        delegate: Item {
            x: 5
            width: 400
            height: 20

            MouseArea {
                anchors.fill: parent
                onClicked: userlistview.currentIndex = index
            }

            Row {
                spacing: 10

                Rectangle {
                    width: 100
                    id: irow1
                    anchors.left: parent.left
                    Text {
                        text: firstname
                        anchors.fill: parent
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    border.color: black
                    border.width: 2
                }
                Rectangle {
                    anchors.left: irow1.right
                    width: 100
                    id: irow2
                    Text {
                        text: lastname
                        wrapMode: Text.WordWrap
                        elide: Text.ElideLeft
                        anchors.fill: parent
                        maximumLineCount: 1
                        anchors.verticalCenter: parent.verticalCenter
                        width: 100
                    }
                    border.color: black
                    border.width: 2
                }
                Rectangle {
                    anchors.left: irow2.right
                    width: 100
                    id: irow3
                    Text {
                        text: datecreated
                        anchors.fill: parent
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    border.color: black
                    border.width: 2
                }
            }
        }
    }
}
