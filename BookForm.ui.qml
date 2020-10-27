import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls 1.4

Page {
    width: 600
    height: 400

    title: qsTr("Add Book Page")
    property alias registrationbutton: registrationbutton
    property alias textInputDescription: textInputDescription
    property alias textInputName: textInputName
    property alias textInputPublishDate: textInputPublishDate
    property string textInputPublishDateFull
    property alias textInputAuthors: textInputAuthors
    property alias addauthor: addauthor
    property alias authorsmodel: authorsmodel
    property alias authorsbox: authorsbox
    property alias calendar1: calendar1

    Text {
        id: element
        x: 140
        y: 70
        width: 73
        height: 20
        text: qsTr("Name")
        font.pixelSize: 12
    }
    Rectangle {
        x: 270
        y: 70
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
        y: 100
        width: 119
        height: 20
        text: qsTr("description")
        font.pixelSize: 12
    }
    Rectangle {
        x: 270
        y: 100
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
        y: 130
        width: 119
        height: 20
        text: qsTr("Publish Date")
        elide: Text.ElideRight
        font.pixelSize: 12
    }
    Rectangle {
        x: 270
        y: 130
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
        y: 130
        Text {
            id: name
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
        y: 150
        z: 3
    }

    Text {
        id: element3
        x: 140
        y: 160
        width: 119
        height: 20
        font.pixelSize: 12
        text: qsTr("Authors")
    }
    Rectangle {
        x: 270
        y: 160
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
        y: 180
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
        y: 200
        Text {
            id: name1
            anchors.fill: parent
            text: qsTr("Add Author")
            color: "black"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Button {
        width: 200
        height: 30
        id: registrationbutton
        x: 209
        y: 258
        Text {
            id: name2
            anchors.fill: parent
            text: qsTr("Register")
            color: "black"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}
