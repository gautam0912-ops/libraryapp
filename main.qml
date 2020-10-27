import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Stack")
    property alias footerlabel: footerlabel

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent
            ItemDelegate {
                text: qsTr("BookRent")
                width: parent.width
                onClicked: {
                    stackView.push("BookRent.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("UserRegistration")
                width: parent.width
                onClicked: {
                    stackView.push("UserRegistration.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("UserList")
                width: parent.width
                onClicked: {
                    stackView.push("UserList.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("AuthorRegistration")
                width: parent.width
                onClicked: {
                    stackView.push("Author.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Book Add")
                width: parent.width
                onClicked: {
                    stackView.push("Book.qml")
                    drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: "HomeForm.ui.qml"
        anchors.fill: parent
    }

    footer: ToolBar {
        id: appfooter
        contentHeight: toolButton.implicitHeight

        Label {
            id: footerlabel
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

}
