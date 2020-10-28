import QtQuick 2.4

UserListForm {

    Timer {
            id: clicktimer
            interval: 50; running: false; repeat: false
            onTriggered: {
                clicktimer.stop()
                console.info(userlistmodel.get(userlistview.currentIndex).firstname)
            }
        }

    listmousearea.onClicked: {
        clicktimer.stop()
        clicktimer.start()
        mouse.accepted = false
    }

    Component.onCompleted: {
        getData()
        //userlistmodel.append({'firstname': 'wwwwwwww', 'lastname': 'kkkkkkkkk', 'datecreated': '2222222222'})
        //userlistmodel.append({'firstname': 'wwwwwwwe', 'lastname': 'kkkkkkkkl', 'datecreated': '2222222223'})
        //userlistmodel.append({'firstname': 'wwwwwwwd', 'lastname': 'kkkkkkkkw', 'datecreated': '2222222229'})
    }

    function getData() {
        var xmlhttp = new XMLHttpRequest();

        var theUrl = "http://localhost:3000/bookusers";
        //xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        console.info("Getting user list......")

        xmlhttp.onreadystatechange=function() {
                   if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                       footerlabel.text = "Getting user list succeeded"
                       var objarr = JSON.parse(xmlhttp.responseText);
                       for(var i = 0; i < objarr.length; i++) {
                           var obj = objarr[i];
                           userlistmodel.append({'firstname': obj.firstname, 'lastname': obj.lastname, 'datecreated': obj.datecreated})
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
