import QtQuick 2.4

LoginForm {
    onVisibleChanged: {
        textInputUserName.activeFocus = true
        textInputUserName.forceActiveFocus()
    }

    Keys.onPressed: {
        console.info('loginbutton clicked='+event.key+', item='+activeFocusItem)
            if ((event.key === Qt.Key_Return) && (activeFocusItem === loginbutton)) {
                loginbutton.onClicked()
            }
        }

    loginbutton.onClicked: {
        console.info('eeeeeeeeeeee---eee')
        var xmlhttp = new XMLHttpRequest();

        var theUrl = "http://localhost:3000/login";
        xmlhttp.open("POST", theUrl);
        xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

        console.info("Logging in......")
        var d = new Date();

        var text1 =     '{"email":"' + textInputUserName.text + '",'+
                          '"password":"' + textInputPassword.text + '"'
                         +'}';
        var obj1 = JSON.parse(text1)

        xmlhttp.onreadystatechange=function() {
                   if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                       footerlabel.text = "User login successfull"
                       var obj = JSON.parse(xmlhttp.responseText);
                       authtoken = "Bearer " + obj.accessToken
                       console.info(authtoken)
                       logitem.authenticated()
                   }
                   else if(xmlhttp.readyState == 4) {
                       footerlabel.text = "User login failed"
                   }
               }

        console.info('calling the URL.....')
        xmlhttp.send(JSON.stringify(obj1));
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
