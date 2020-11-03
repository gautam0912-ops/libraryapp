import QtQuick 2.4

BookForm {
    addauthor.onClicked: {
        var newauthor = authorsmodel.get(authorsbox.currentIndex).name
        if(textInputAuthors.text.indexOf(newauthor) === -1)
        {
            if(textInputAuthors.text !== '') {
                textInputAuthors.text = textInputAuthors.text + ',' + newauthor
            }
            else {
                textInputAuthors.text = authorsmodel.get(authorsbox.currentIndex).name
            }
        }
    }

    calendar1.onClicked: {
        var theSelDate = calendar1.selectedDate
        textInputPublishDate.text = theSelDate.toLocaleDateString()
        textInputPublishDateFull = theSelDate.toString()
        calendar1.visible = false
    }

    Component.onCompleted: {
        getData()
    }

    registrationbutton.onClicked: {
        var xmlhttp = new XMLHttpRequest();

        var theUrl = "http://localhost:3000/books";
        xmlhttp.open("POST", theUrl);
        xmlhttp.setRequestHeader('Authorization', authtoken);
        xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        console.info("Adding new book......")
        var d = new Date();
        if((textInputName.text === '') || (textInputDescription.text === '') || (textInputPublishDateFull === "") || (textInputAuthors.text === '')) {
            footerlabel.text = "Please enter all fields in the form"
            return
        }

        var text1 =     '{"name":"' + textInputName.text + '",'+
                          '"description":"' + textInputDescription.text + '",'+
                          '"authors":"' + textInputAuthors.text + '",'+
                          '"publishdate":"' + textInputPublishDateFull + '",'+
                          '"availability_to":"' + (new Date()).toString() + '",'+
                          '"availability":1'
                          +'}';
        var obj1 = JSON.parse(text1)

        xmlhttp.onreadystatechange=function() {
                   if (xmlhttp.readyState == 4 && xmlhttp.status == 201) {
                       footerlabel.text = "Book added successfully"
                       textInputName.text = ''
                       textInputDescription.text = ''
                       textInputAuthors.text = ''
                       textInputPublishDateFull = ''
                       textInputPublishDate.text = ''
                   }
                   else if(xmlhttp.readyState == 4) {
                       footerlabel.text = "Book add failed"
                   }
               }

        console.info('calling the URL.....')
        xmlhttp.send(JSON.stringify(obj1));
    }

    function getData() {
        var xmlhttp = new XMLHttpRequest();

        var theUrl = "http://localhost:3000/authors";
        console.info("Getting author list......")

        xmlhttp.onreadystatechange=function() {
                   if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                       //footerlabel.text = "Getting user list succeeded"
                       var objarr = JSON.parse(xmlhttp.responseText);
                       for(var i = 0; i < objarr.length; i++) {
                           var obj = objarr[i];
                           authorsmodel.append({'name': obj.name})
                       }
                   }
                   else if(xmlhttp.readyState == 4) {
                       footerlabel.text = "Getting author list failed"
                   }
               }

        console.info('calling the URL.....')
        xmlhttp.open("GET", theUrl);
        xmlhttp.setRequestHeader('Authorization', authtoken);
        xmlhttp.send();
    }

}
