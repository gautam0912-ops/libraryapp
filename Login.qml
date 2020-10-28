import QtQuick 2.4

LoginForm {
    loginbutton.onClicked: {
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
                       var obj = JSON.parse(doc.responseText);
                       authtoken = "Bearer " + obj.accessToken
                   }
                   else if(xmlhttp.readyState == 4) {
                       footerlabel.text = "User login failed"
                   }
               }

        console.info('calling the URL.....')
        xmlhttp.send(JSON.stringify(obj1));
    }
}
