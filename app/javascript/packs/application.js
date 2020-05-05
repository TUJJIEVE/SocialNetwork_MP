// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.



require("@rails/ujs").start()

require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
// require("tree") //commment this not required

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "bootstrap"


window.showAndHide = function(id){
    var x = document.getElementById(id);    
    if (x.style.display === "none") {
        x.style.display = "block";
    } else {
        x.style.display = "none";
    }
}

window.getNotifications = function(){
    console.log("calling getNotifications");    
    jQuery.ajax({
        url: "/users/notifications/",
        type: "get",
        success: function(data) { 
            console.log(data.friendRequests);
            document.getElementById("notifications").innerHTML = JSON.stringify(data);
        }
    });
}


window.fetchNewMessages = function(){
    console.log("fetiching new messages if any");        
    var convId = document.getElementById("conversationId").innerHTML;
    jQuery.ajax({
        url: "/messages/fetchlatest/"+convId+"/" + lastmsgid +"/" ,
        type: "get",
        success: function(data) { 
            console.log(data);            
            if(data.messages) {
                data.messages.forEach(element => {
                    var msg = "";
                    if (element.user_id == document.getElementById("currentUserId").innerHTML){
                        msg += document.getElementById("currentUserUname").innerHTML
                    }else{
                        msg += document.getElementById("otherUserUname").innerHTML
                    }
                    msg += " : "
                    msg += element.body ;               
                    console.log(data.messages);
                    lastmsgid = element.id;
                    document.getElementById("messagebox").innerHTML += ("<div class=\"card\">"+msg+"</div>");
                });                
            }
        }
    });
}

//constants
var timeForNotifications = 3500;
var timeForGetMessages = 2000;



//global vars
var recFetchMsg = undefined; 
var lastmsgid = 0;


// ready function
$(document).ready(function() {    
    window.setInterval(function(){
        getNotifications()
      }, timeForNotifications);
    console.log("loaded application js");   
});

//on turbo linkschange function
$(document).on('turbolinks:load', function() { 
   //for messages index page only
    var message_index_page = document.getElementById("messages_index");     
    console.log("page changed ... ");
    if(message_index_page){
        console.log("loading messsages specific js");  
        lastmsgid = document.getElementById("lastMsgId").innerHTML;
        recFetchMsg = window.setInterval(function(){            
                fetchNewMessages();                
            },timeForGetMessages);        
    }else{
        if(recFetchMsg){
            clearInterval(recFetchMsg);
            console.log("stoped recFetchMsg");
        }
   }
});