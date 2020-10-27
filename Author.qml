import QtQuick 2.4

AuthorForm {
    registrationbutton.onClicked: {
        var xmlhttp = new XMLHttpRequest();

        var theUrl = "http://localhost:3000/authors";
        xmlhttp.open("POST", theUrl);
        xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        console.info("Creating new author......")
        var d = new Date();

        var text1 =     '{"name":"' + textInputName.text + '",'+
                          '"dob":"' + textInputDOB.text + '",'+
                          '"gender":"' + textInputGender.text + '"'
                         +'}';
        var obj1 = JSON.parse(text1)

        xmlhttp.onreadystatechange=function() {
                   if (xmlhttp.readyState == 4 && xmlhttp.status == 201) {
                       footerlabel.text = "Author registration successfull"
                       textInputDOB.text = ''
                       textInputName.text = ''
                       textInputGender.text = ''
                   }
                   else if(xmlhttp.readyState == 4) {
                       footerlabel.text = "Author registration failed"
                   }
               }

        console.info('calling the URL.....')
        xmlhttp.send(JSON.stringify(obj1));
    }

    Component.onCompleted: {
        textInputName.focus = true
    }
}
