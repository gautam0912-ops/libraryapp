import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    width: 600
    height: 400

    id: listpage
    title: qsTr("Book List")
    property alias booklistmodel: booklistmodel
    property alias booklistview: booklistview
    property alias listmousearea: listmousearea
    property alias searchbox: searchbox
    property alias searchboxbutton: searchboxbutton

    Rectangle {
        id: searchbox
        width: 200
        height: 20
        y: 20
        x: 120
        anchors.left: searchtext.right
        border.color: black
        border.width: 2
        TextInput {
            text: ""
            anchors.fill: parent
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
        }
    }
    Button {
        id: searchboxbutton
        width: 50
        height: 20
        y: 20
        anchors.left: searchbox.right
        Text {
            id: name
            anchors.fill: parent
            text: qsTr("Search")
            color: "black"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            padding: 5
        }
    }

    ListView {
        id: booklistview
        x: 70
        y: 50
        width: 400
        height: 160
        highlightRangeMode: ListView.NoHighlightRange

        model: ListModel {
            id: booklistmodel
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
                    width: 30
                    id: hcol1
                    anchors.left: parent.left
                    Text {
                        text: "ID"
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
                        text: "NAME"
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
                        text: "DESCRIPTION"
                        anchors.fill: parent
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }
                }
                Rectangle {
                    anchors.left: hcol3.right
                    width: 100
                    id: hcol4
                    Text {
                        text: "AUTHORS"
                        anchors.fill: parent
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }
                }
                Rectangle {
                    anchors.left: hcol4.right
                    width: 10
                    id: hcol5
                    Text {
                        text: "AVAILABILITY"
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
                onClicked: booklistview.currentIndex = index
            }

            Row {
                spacing: 10

                Rectangle {
                    width: 30
                    id: irow1
                    anchors.left: parent.left
                    Text {
                        text: id
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
                        text: name
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
                        text: description
                        anchors.fill: parent
                        wrapMode: Text.WordWrap
                        elide: Text.ElideLeft
                        maximumLineCount: 1
                        anchors.verticalCenter: parent.verticalCenter
                        width: 100
                    }
                    border.color: black
                    border.width: 2
                }
                Rectangle {
                    anchors.left: irow3.right
                    width: 100
                    id: irow4
                    Text {
                        text: authors
                        anchors.fill: parent
                        wrapMode: Text.WordWrap
                        elide: Text.ElideLeft
                        maximumLineCount: 1
                        anchors.verticalCenter: parent.verticalCenter
                        width: 100
                    }
                    border.color: black
                    border.width: 2
                }
                Rectangle {
                    anchors.left: irow4.right
                    width: 10
                    id: irow5
                    Text {
                        text: availability
                        anchors.fill: parent
                        wrapMode: Text.WordWrap
                        elide: Text.ElideLeft
                        maximumLineCount: 1
                        anchors.verticalCenter: parent.verticalCenter
                        width: 100
                    }
                    border.color: black
                    border.width: 2
                }
            }
        }
    }
}
