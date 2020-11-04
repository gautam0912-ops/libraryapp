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
                    usersbox.currentIndex = i;
                    break;
                }
            }
        }
    }

    searchboxbutton.onClicked: {
        getData(searchboxtext.text)
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
        getData("")
        getUserData()
        booklistview.currentIndex = -1
    }

    returnbutton.onClicked: {
        rentFunction('return')
    }

    rentbutton.onClicked: {
        rentFunction('rent')
    }

    function rentFunction(type) {
        var xmlhttp = new XMLHttpRequest();
        var selid = -1
        selid = booklistmodel.get(booklistview.currentIndex).id
        var theUrl = "http://localhost:3000/books/"+selid;
        xmlhttp.open("PUT", theUrl);
        xmlhttp.setRequestHeader('Authorization', authtoken);
        xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

        if(type === 'rent') {
            console.info("Renting book......")
            var d = new Date();
            var dto = new Date(textInputAvailabletoFull)
            if((d.toLocaleDateString() === dto.toLocaleDateString) || (dto <= d)) {
                footerlabel.text = "Availableto date not set properly"
                return
            }
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

        var text1 = ''
        if(type === 'rent') {
            text1 =     '{"user":' + usrid + ','+
                              '"availability_to":"' + textInputAvailabletoFull + '",'+
                    '"name":"' + textInputName.text + '",'+
                    '"description":"' + textInputDescription.text + '",'+
                    '"publishdate":"' + textInputPublishDateFull + '",'+
                    '"authors":"' + textInputAuthors.text + '",'+
                    '"availability":0'
                              +'}';
        }
        else if(type === 'return') {
            text1 =     '{"user":' + usrid + ','+
                              '"availability_to":"' + (new Date()).toString() + '",'+
                    '"name":"' + textInputName.text + '",'+
                    '"description":"' + textInputDescription.text + '",'+
                    '"publishdate":"' + textInputPublishDateFull + '",'+
                    '"authors":"' + textInputAuthors.text + '",'+
                    '"availability":1'
                              +'}';
        }
        else if(type === 'update') {
            text1 =     '{"user":' + usrid + ','+
                              '"availability_to":"' + textInputAvailabletoFull + '",'+
                    '"name":"' + textInputName.text + '",'+
                    '"description":"' + textInputDescription.text + '",'+
                    '"publishdate":"' + textInputPublishDateFull + '",'+
                    '"authors":"' + textInputAuthors.text + '",'+
                    '"availability":'+(booklistmodel.get(booklistview.currentIndex).available).toString()
                              +'}';
        }


        var obj1 = JSON.parse(text1)

        xmlhttp.onreadystatechange=function() {
                   if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                       if(type === 'rent')
                       {
                           footerlabel.text = "Book id="+selid.toString()+" has been rented successfully to " + usrid.toString()
                           textInputAvailable.text = 'NO'
                           booklistmodel.setProperty(booklistview.currentIndex, 'available', 0)
                           logitem.printLog(footerlabel.text)
                       }
                       else if(type === 'return')
                       {
                           footerlabel.text = "Book id="+selid.toString()+" has been returned by " + usrid.toString()
                           textInputAvailable.text = 'YES'
                           booklistmodel.setProperty(booklistview.currentIndex, 'available', 1)
                           logitem.printLog(footerlabel.text)
                       }
                       else if(type === 'update')
                       {
                           footerlabel.text = "Book id="+selid.toString()+" has been updated"
                           logitem.printLog(footerlabel.text)
                           getData('')
                       }
                   }
                   else if(xmlhttp.readyState === 4) {
                       footerlabel.text = "Operation failed"
                   }
               }

        console.info('calling the URL.....')
        xmlhttp.send(JSON.stringify(obj1));
    }

    function clearPage() {
        booklistmodel.clear()
        textInputName.text = ''
        textInputDescription.text = ''
        textInputPublishDate.text = ''
        textInputPublishDateFull = ''
        textInputAuthors.text = ''
        textInputAvailable.text = ''
        textInputAvailableto.text = ''
        textInputAvailabletoFull = ''
        booklistview.currentIndex = -1
    }

    function getData(searchstring) {
        clearPage()
        var xmlhttp = new XMLHttpRequest();
        var theUrl = "http://localhost:3000/books";

        if(searchstring !== '') {
            theUrl = theUrl + '?q=' + searchstring
            if(currentmode === 'allrents') {
                theUrl = theUrl + '&availability=0'
            }
        }
        else {
            if(currentmode === 'allrents') {
                theUrl = theUrl + '?availability=0'
            }
        }

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
        xmlhttp.setRequestHeader('Authorization', authtoken);
        xmlhttp.send();
    }
    function getUserData() {
        var xmlhttp = new XMLHttpRequest();

        var theUrl = "http://localhost:3000/bookusers";
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
        xmlhttp.setRequestHeader('Authorization', authtoken);
        xmlhttp.send();
    }

    updatebutton.onClicked: {
        rentFunction('update')
    }

    addauthor.onClicked: {
    }
}
