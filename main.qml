import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    id: window
    visible: true
    width: 700
    height: 660
    title: qsTr("Library Application")
    property alias footerlabel: footerlabel
    property string currentmode
    property string authtoken
    property alias logitem: logitem

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
                text: qsTr("All Books")
                width: parent.width
                onClicked: {
                    currentmode = 'allbooks'
                    stackView.push("BookRent.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("All Rents")
                width: parent.width
                onClicked: {
                    currentmode = 'allrents'
                    stackView.push("BookRent.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("UserRegistration")
                width: parent.width
                onClicked: {
                    currentmode = ''
                    stackView.push("UserRegistration.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("UserList")
                width: parent.width
                onClicked: {
                    currentmode = ''
                    stackView.push("UserList.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("AuthorRegistration")
                width: parent.width
                onClicked: {
                    currentmode = ''
                    stackView.push("Author.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Book Add")
                width: parent.width
                onClicked: {
                    currentmode = ''
                    stackView.push("Book.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Login")
                width: parent.width
                onClicked: {
                    currentmode = ''
                    stackView.push("Login.qml")
                    drawer.close()
                }
            }

        }
    }

    StackView {
        id: stackView
        initialItem: "Home.qml"
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

    Item {
        id: logitem
        signal printLog(string data)
        onPrintLog:  {
            var xmlhttp = new XMLHttpRequest();

            var theUrl = "http://localhost:3000/logs";
            xmlhttp.open("POST", theUrl);
            xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            var d = new Date();

            var text1 =     '{"date":"' + (new Date()).toString() + '",'+
                              '"info":"' + data + '"'
                             +'}';
            var obj1 = JSON.parse(text1)

            xmlhttp.onreadystatechange=function() {
                       if (xmlhttp.readyState === 4 && xmlhttp.status === 201) {
                       }
                       else if(xmlhttp.readyState == 4) {
                       }
                   }

            xmlhttp.send(JSON.stringify(obj1));
        }
    }


}
