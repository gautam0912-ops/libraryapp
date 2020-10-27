import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    width: 600
    height: 400

    title: qsTr("Author Page")
    property alias registrationbutton: registrationbutton
    property alias textInputDOB: textInputDOB
    property alias textInputName: textInputName
    property alias textInputGender: textInputGender

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
        text: qsTr("Name")
        font.pixelSize: 12
    }

    Text {
        id: element1
        x: 140
        y: 124
        width: 73
        height: 20
        text: qsTr("DOB (dd/mm/yyyy)")
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
            anchors.fill: parent
            id: textInputDOB
            text: qsTr("")
            font.pixelSize: 12
            padding: 5
            focus: true
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
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Text {
        id: element2
        x: 140
        y: 171
        width: 92
        height: 20
        text: qsTr("Gender (M/F)")
        elide: Text.ElideRight
        font.pixelSize: 12
    }

    Rectangle {
        x: 271
        y: 171
        width: 23
        height: 20
        border.color: black
        border.width: 2

        TextInput {
            anchors.fill: parent
            id: textInputGender
            text: qsTr("")
            font.pixelSize: 12
            padding: 5
            focus: true
        }
    }
}
