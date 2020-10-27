import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    width: 600
    height: 400

    title: qsTr("Page 1")

    Label {
        text: qsTr("You are on Page 1.")
        anchors.verticalCenterOffset: 130
        anchors.horizontalCenterOffset: -11
        anchors.centerIn: parent
    }

    ItemDelegate {
        id: itemDelegate
        x: 158
        y: 60
        width: 332
        height: 226
        text: qsTr("Item Delegate")
    }
}
