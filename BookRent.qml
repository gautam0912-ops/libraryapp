import QtQuick 2.4

BookRentForm {
    Timer {
            id: clicktimer
            interval: 50; running: false; repeat: false
            onTriggered: {
                clicktimer.stop()
                console.info(booklistmodel.get(booklistview.currentIndex).name)
                textInputName.text = booklistmodel.get(booklistview.currentIndex).name
                textInputDescription.text = booklistmodel.get(booklistview.currentIndex).description
                textInputPublishDate.text = (new Date(booklistmodel.get(booklistview.currentIndex).publishdate)).toLocaleDateString()
                textInputAuthors.text = booklistmodel.get(booklistview.currentIndex).authors
                if(booklistmodel.get(booklistview.currentIndex).available === 1) {
                    textInputAvailable.text = 'YES'
                }
                else {
                    textInputAvailable.text = 'NO'
                }

                textInputAvailableto.text = (new Date(booklistmodel.get(booklistview.currentIndex).availability_to)).toLocaleDateString()
                if(booklistmodel.get(booklistview.currentIndex).available !== 1) {

                }
            }
        }

    listmousearea.onClicked: {
        clicktimer.stop()
        clicktimer.start()
        mouse.accepted = false
    }

    Component.onCompleted: {
        getData()
        getUserData()
    }

    function getData() {
        var xmlhttp = new XMLHttpRequest();

        var theUrl = "http://localhost:3000/books";
        console.info("Getting book list......")

        xmlhttp.onreadystatechange=function() {
                   if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                       footerlabel.text = "Getting book list succeeded"
                       var objarr = JSON.parse(xmlhttp.responseText);
                       for(var i = 0; i < objarr.length; i++) {
                           var obj = objarr[i];
                           booklistmodel.append({'id':obj.id, 'name': obj.name, 'description': obj.description, 'publishdate': obj.publishdate, 'available': obj.availability, 'availability_to': obj.availability_to, 'authors': obj.authors, 'rentuser': obj.rentuser})
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
                   if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
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
