import QtQuick 2.12
import QtQuick.Controls 2.5

import QtQuick.Controls 1.4

//import QtQuick.Controls 2.15
Page {
    width: 700
    height: 600

    id: listpage
    title: qsTr("Book List")
    property alias booklistmodel: booklistmodel
    property alias booklistview: booklistview
    property alias listmousearea: listmousearea
    property alias searchboxtext: searchboxtext
    property alias searchboxbutton: searchboxbutton
    property alias textInputName: textInputName
    property alias textInputDescription: textInputDescription
    property alias textInputPublishDate: textInputPublishDate
    property alias textInputAuthors: textInputAuthors
    property alias textInputAvailable: textInputAvailable
    property alias textInputAvailableto: textInputAvailableto
    property string textInputAvailabletoFull
    property string textInputPublishDateFull
    property alias usersbox: usersbox
    property alias usersmodel: usersmodel
    property alias rentbutton: rentbutton
    property alias calendarrent: calendarrent

    Rectangle {
        id: searchbox
        width: 200
        height: 20
        y: 20
        x: 190
        anchors.left: searchtext.right
        border.color: black
        border.width: 2
        TextInput {
            id: searchboxtext
            text: ""
            anchors.fill: parent
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            padding: 4
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
        x: 20
        y: 50
        width: 650
        height: 200
        highlightRangeMode: ListView.NoHighlightRange
        ScrollBar.vertical: ScrollBar {}
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        headerPositioning: ListView.OverlayHeader

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

        header: Rectangle {
            x: 5
            height: 40
            width: 650
            z: 2
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
                    width: 200
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
                    width: 150
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
                    width: 150
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
                    width: 30
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
            width: 650
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
                    width: 200
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
                    width: 150
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
                    width: 150
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
                        text: available === 1 ? "YES" : "NO"
                        anchors.fill: parent
                        maximumLineCount: 1
                        anchors.verticalCenter: parent.verticalCenter
                        width: 30
                    }
                    border.color: black
                    border.width: 2
                }
            }
        }
    }

    Text {
        id: nametext
        x: 140
        y: 300
        width: 73
        height: 20
        text: qsTr("Name")
        font.pixelSize: 12
    }
    Rectangle {
        x: 270
        y: nametext.y
        width: 204
        height: 20
        border.color: black
        border.width: 2
        TextInput {
            anchors.fill: parent
            id: textInputName
            text: qsTr("")
            font.pixelSize: 12
            padding: 5
            focus: true
        }
    }

    Text {
        id: element1
        x: 140
        y: nametext.y + 30
        width: 119
        height: 20
        text: qsTr("description")
        font.pixelSize: 12
    }
    Rectangle {
        x: 270
        y: nametext.y + 30
        width: 204
        height: 20
        border.color: black
        border.width: 2
        TextInput {
            anchors.fill: parent
            id: textInputDescription
            text: qsTr("")
            font.pixelSize: 12
            padding: 5
            focus: true
        }
    }

    Text {
        id: element2
        x: 140
        y: nametext.y + 60
        width: 119
        height: 20
        text: qsTr("Publish Date")
        elide: Text.ElideRight
        font.pixelSize: 12
    }
    Rectangle {
        x: 270
        y: nametext.y + 60
        width: 200
        height: 20
        border.color: black
        border.width: 2
        Text {
            anchors.fill: parent
            id: textInputPublishDate
            text: qsTr("")
            font.pixelSize: 12
            padding: 5
            focus: true
        }
    }
    Button {
        id: datechooser
        width: 50
        height: 20
        x: 480
        y: nametext.y + 60
        Text {
            id: name1
            anchors.fill: parent
            text: qsTr("Select")
            color: "black"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            padding: 5
        }
        onClicked: calendar1.visible = true
    }
    Calendar {
        id: calendar1
        visible: false
        x: 270
        y: nametext.y + 80
        z: 3
    }

    Text {
        id: element3
        x: 140
        y: nametext.y + 90
        width: 119
        height: 20
        font.pixelSize: 12
        text: qsTr("Authors")
    }
    Rectangle {
        x: 270
        y: nametext.y + 90
        width: 204
        height: 20
        border.color: black
        border.width: 2
        Text {
            anchors.fill: parent
            id: textInputAuthors
            text: qsTr("")
            font.pixelSize: 12
            padding: 5
            focus: true
        }
    }
    Rectangle {
        x: 270
        y: nametext.y + 110
        width: 204
        height: 20
        border.color: black
        border.width: 2
        ComboBox {
            currentIndex: 1
            id: authorsbox
            anchors.fill: parent
            model: ListModel {
                id: authorsmodel
            }
        }
    }
    Button {
        width: 150
        height: 20
        id: addauthor
        x: 270
        y: nametext.y + 130
        Text {
            id: name2
            anchors.fill: parent
            text: qsTr("Add Author")
            color: "black"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Text {
        id: element4
        x: 140
        y: nametext.y + 160
        width: 100
        height: 20
        font.pixelSize: 12
        text: qsTr("Available")
    }
    Rectangle {
        x: 270
        y: nametext.y + 160
        width: 30
        height: 20
        border.color: black
        border.width: 2
        Text {
            anchors.fill: parent
            id: textInputAvailable
            text: qsTr("")
            font.pixelSize: 12
            padding: 5
            focus: true
        }
    }
    Rectangle {
        x: 300
        y: nametext.y + 160
        width: 170
        height: 20
        border.color: black
        border.width: 2
        Text {
            anchors.fill: parent
            id: textInputAvailableto
            text: qsTr("")
            font.pixelSize: 12
            padding: 5
            focus: true
        }
    }
    Button {
        id: datechooserrent
        width: 50
        height: 20
        x: 480
        y: nametext.y + 160
        Text {
            id: name3
            anchors.fill: parent
            text: qsTr("Select")
            color: "black"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            padding: 5
        }
        onClicked: calendarrent.visible = true
    }
    Calendar {
        id: calendarrent
        visible: false
        x: 300
        y: nametext.y + 50
        z: 3
    }

    Text {
        id: element5
        x: 140
        y: nametext.y + 200
        width: 100
        height: 20
        font.pixelSize: 12
        text: qsTr("User")
    }
    Rectangle {
        x: 270
        y: nametext.y + 200
        width: 200
        height: 20
        border.color: black
        border.width: 2
        ComboBox {
            currentIndex: 1
            id: usersbox
            anchors.fill: parent

            model: ListModel {
                id: usersmodel
            }
            textRole: "name"
        }
    }

    Button {
        width: 100
        height: 30
        id: registrationbutton
        x: 200
        y: nametext.y + 240
        Text {
            anchors.fill: parent
            text: qsTr("Update")
            color: "black"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Button {
        width: 100
        height: 30
        id: rentbutton
        x: 310
        y: nametext.y + 240
        Text {
            anchors.fill: parent
            text: qsTr("Rent")
            color: "black"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Button {
        width: 100
        height: 30
        id: returnbutton
        x: 420
        y: nametext.y + 240
        Text {
            anchors.fill: parent
            text: qsTr("Return")
            color: "black"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}
