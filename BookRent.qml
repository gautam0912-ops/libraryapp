import QtQuick 2.4

BookRentForm {
    Timer {
            id: clicktimer
            interval: 50; running: false; repeat: false
            onTriggered: {
                clicktimer.stop()
                console.info(booklistmodel.get(booklistview.currentIndex).name)
            }
        }

    listmousearea.onClicked: {
        clicktimer.stop()
        clicktimer.start()
        mouse.accepted = false
    }

    Component.onCompleted: {
        getData()
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
                           booklistmodel.append({'id':obj.id, 'name': obj.name, 'description': obj.description, 'publishdate': obj.publishdate, 'availability': obj.availability, 'availability_to': obj.availability_to, 'authors': obj.authors})
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
}
