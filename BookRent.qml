import QtQuick 2.4

BookRentForm {
    Timer {
            id: clicktimer
            interval: 50; running: false; repeat: false
            onTriggered: {
                clicktimer.stop()
                setDataForIndex()
            }
        }

    function setDataForIndex() {
        console.info(booklistmodel.get(booklistview.currentIndex).name)
        textInputName.text = booklistmodel.get(booklistview.currentIndex).name
        textInputDescription.text = booklistmodel.get(booklistview.currentIndex).description
        textInputPublishDate.text = (new Date(booklistmodel.get(booklistview.currentIndex).publishdate)).toLocaleDateString()
        textInputPublishDateFull = (new Date(booklistmodel.get(booklistview.currentIndex).publishdate)).toString()
        textInputAuthors.text = booklistmodel.get(booklistview.currentIndex).authors
        if(booklistmodel.get(booklistview.currentIndex).available === 1) {
            textInputAvailable.text = 'YES'
        }
        else {
            textInputAvailable.text = 'NO'
        }

        textInputAvailableto.text = (new Date(booklistmodel.get(booklistview.currentIndex).availability_to)).toLocaleDateString()
        textInputAvailabletoFull = (new Date(booklistmodel.get(booklistview.currentIndex).availability_to)).toString()
        if(booklistmodel.get(booklistview.currentIndex).available === 0) {
            var userid = booklistmodel.get(booklistview.currentIndex).user
            for(var i = 0; i < usersmodel.count; i++) {
                if(userid === usersmodel.get(i).id) {
                    usersbox.currentIndex = i
                    break
                }
            }
        }
    }

    searchboxbutton.onClicked: {

    }

    listmousearea.onClicked: {
        clicktimer.stop()
        clicktimer.start()
        mouse.accepted = false
    }

    calendarrent.onClicked: {
        var theSelDate = calendarrent.selectedDate
        textInputAvailableto.text = theSelDate.toLocaleDateString()
        textInputAvailabletoFull = theSelDate.toString()
        calendarrent.visible = false
    }

    Component.onCompleted: {
        getData()
        getUserData()
        booklistview.currentIndex = -1
    }

    rentbutton.onClicked: {
        var xmlhttp = new XMLHttpRequest();
        var selid = -1
        selid = booklistmodel.get(booklistview.currentIndex).id
        var theUrl = "http://localhost:3000/books/"+selid;
        xmlhttp.open("PUT", theUrl);
        xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        console.info("Renting book......")
        var d = new Date();
        var dto = new Date(textInputAvailabletoFull)
        if((d.toLocaleDateString() === dto.toLocaleDateString) || (dto <= d)) {
            footerlabel.text = "Availableto date not set properly"
            return
        }

        var usrid = -1
        usrid = usersmodel.get(usersbox.currentIndex).id
        if((textInputAvailabletoFull === '') || (selid === -1) || (usrid === -1)) {
            footerlabel.text = "Please select the book and enter availableto fields in the form"
            return
        }

        if((textInputName.text === '') || (textInputDescription.text === '') || (textInputDescription.authors === '')) {
            footerlabel.text = "Please ensure fields are not left blank"
            return
        }

        var text1 =     '{"user":' + usrid + ','+
                          '"availability_to":"' + textInputAvailabletoFull + '",'+
                '"name":"' + textInputName.text + '",'+
                '"description":"' + textInputDescription.text + '",'+
                '"publishdate":"' + textInputPublishDateFull + '",'+
                '"authors":"' + textInputAvailabletoFull + '",'+
                '"availability":0'
                          +'}';
        var obj1 = JSON.parse(text1)

        xmlhttp.onreadystatechange=function() {
                   if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                       footerlabel.text = "Book has been rented successfully"
                       textInputAvailable.text = 'NO'
                       booklistmodel.setProperty(booklistview.currentIndex, 'available', 0)
                   }
                   else if(xmlhttp.readyState == 4) {
                       footerlabel.text = "Book rent failed"
                   }
               }

        console.info('calling the URL.....')
        xmlhttp.send(JSON.stringify(obj1));
    }

    function getData() {
        var xmlhttp = new XMLHttpRequest();

        var theUrl = "http://localhost:3000/books";
        console.info("Getting book list......")

        xmlhttp.onreadystatechange=function() {
                   if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                       footerlabel.text = "Getting book list succeeded"
                       var objarr = JSON.parse(xmlhttp.responseText);
                       for(var i = 0; i < objarr.length; i++) {
                           var obj = objarr[i];
                           booklistmodel.append({'id':obj.id, 'name': obj.name, 'description': obj.description, 'publishdate': obj.publishdate, 'available': obj.availability, 'availability_to': obj.availability_to, 'authors': obj.authors, 'user': obj.user})
                       }
                   }
                   else if(xmlhttp.readyState == 4) {
                       footerlabel.text = "Getting book list failed"
                   }
               }

        console.info('calling the URL.....')
        xmlhttp.open("GET", theUrl);
        xmlhttp.send();
    }
    function getUserData() {
        var xmlhttp = new XMLHttpRequest();

        var theUrl = "http://localhost:3000/users";
        console.info("Getting user list......")

        xmlhttp.onreadystatechange=function() {
                   if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                       footerlabel.text = "Getting book list succeeded"
                       var objarr = JSON.parse(xmlhttp.responseText);
                       for(var i = 0; i < objarr.length; i++) {
                           var obj = objarr[i];
                           usersmodel.append({'id':obj.id, 'name': obj.firstname})
                       }
                   }
                   else if(xmlhttp.readyState == 4) {
                       footerlabel.text = "Getting user list failed"
                   }
               }

        console.info('calling the URL.....')
        xmlhttp.open("GET", theUrl);
        xmlhttp.send();
    }

}
