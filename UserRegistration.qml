import QtQuick 2.4

UserRegistrationForm {
    registrationbutton.onClicked: {
        var xmlhttp = new XMLHttpRequest();

        var theUrl = "http://localhost:3000/bookusers";
        xmlhttp.open("POST", theUrl);
        xmlhttp.setRequestHeader('Authorization', authtoken);
        xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        console.info("Creating new user......")
        var d = new Date();

        var text1 =     '{"firstname":"' + textInputName.text + '",'+
                          '"lastname":"' + textInputLastName.text + '",'+
                          '"datecreated":"' + d.toString() + '"'
                         +'}';
        var obj1 = JSON.parse(text1)

        xmlhttp.onreadystatechange=function() {
                   if (xmlhttp.readyState == 4 && xmlhttp.status == 201) {
                       footerlabel.text = "User registration successfull"
                       textInputName.text = ''
                       textInputLastName.text = ''
                       //console.info(doc.responseText)
                       //var obj = JSON.parse(doc.responseText);
                       //console.info("THE DATA FROM JSON="+obj.body)
                       //myFunction(xmlhttp.responseText);
                   }
                   else if(xmlhttp.readyState == 4) {
                       footerlabel.text = "User registration failed"
                   }
               }

        console.info('calling the URL.....')
        xmlhttp.send(JSON.stringify(obj1));
        //xmlhttp.send(JSON.stringify({ "firstname": "hhhhhhh", "lastname": "ggggggg", "datecreated": "@{currentdate}"}));
    }

    Component.onCompleted: {
        textInputName.focus = true
    }
}
