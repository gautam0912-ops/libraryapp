import QtQuick 2.4

HomeForm {
    Component.onCompleted: {
        getBooks()
    }

    function getBooks() {
            var xmlhttp = new XMLHttpRequest();

            var theUrl = "http://localhost:3000/books";
            console.info("Getting book list......")
            var totalbooksi = 0
            var totalrentedbooksi = 0

            xmlhttp.onreadystatechange=function() {
                       if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                           var objarr = JSON.parse(xmlhttp.responseText);
                           totalbooksi = objarr.length
                           for(var i = 0; i < objarr.length; i++) {
                               var obj = objarr[i];
                               if(obj.availability === 0) {
                                   totalrentedbooksi = totalrentedbooksi + 1
                               }
                               //booklistmodel.append({'id':obj.id, 'name': obj.name, 'description': obj.description, 'publishdate': obj.publishdate, 'available': obj.availability, 'availability_to': obj.availability_to, 'authors': obj.authors, 'user': obj.user})
                           }
                           totalbooks = totalbooksi.toString()
                           totalrentedbooks = totalrentedbooksi.toString()
                       }
                       else if(xmlhttp.readyState === 4) {
                           footerlabel.text = "Getting book list failed"
                       }
                   }

            console.info('calling the URL.....')
            xmlhttp.open("GET", theUrl);
            xmlhttp.send();
    }
}
