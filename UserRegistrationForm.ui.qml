import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    width: 600
    height: 400

    title: qsTr("User Registration")
    property alias textInputLastName: textInputLastName
    property alias textInputName: textInputName
    property alias registrationbutton: registrationbutton

    Rectangle {
        x: 271
        y: 68
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
        id: element
        x: 140
        y: 68
        width: 73
        height: 20
        text: qsTr("First Name")
        font.pixelSize: 12
    }

    Text {
        id: element1
        x: 140
        y: 124
        width: 73
        height: 20
        text: qsTr("Last Name")
        font.pixelSize: 12
    }

    Rectangle {
        x: 271
        y: 124
        width: 204
        height: 20
        border.color: black
        border.width: 2

        TextInput {
            id: textInputLastName
            text: qsTr("")
            font.pixelSize: 12
            anchors.fill: parent
            padding: 5
        }
    }

    Button {
        width: 200
        height: 42
        id: registrationbutton
        x: 209
        y: 258
        Text {
            id: name
            anchors.fill: parent
            text: qsTr("Register")
            color: "black"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}
