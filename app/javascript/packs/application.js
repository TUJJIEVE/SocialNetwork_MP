// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.



require("@rails/ujs").start()

require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")





// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "bootstrap"

//<script src="./../select2.min.js"></script>


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
            document.getElementById("numberofnewFriendRequests").innerHTML = JSON.stringify(data.friendRequests);
        }
    });
}

window.getSelectedOptionValues = function(sel) {
    var opts = [],opt;
    var len = sel.options.length;
    for (var i = 0; i < len; i++) {
      opt = sel.options[i];
  
      if (opt.selected) {
        opts.push(opt.innerHTML);        
      }
    }
  
    return opts;
}
window.makeNewQuestionDropDownResponsibe = function(){
    
    var mydropdown = document.getElementById('newQuestionDropDown');

    mydropdown.onchange = function(){
        console.log("drop down changed");
        var finalTagString = getSelectedOptionValues(this).join(',');
        console.log(finalTagString);        
        document.getElementById('all_tags_for_newQuestionShow').innerHTML = finalTagString;
        document.getElementById('all_tags_for_newQuestionValue').innerHTML = finalTagString;
    }
}


window.makeUserIntrestEditDropDownResponsibe = function(){
    
    var mydropdown = document.getElementById('tagDropDownForUserInterst');

    mydropdown.onchange = function(){
        console.log("drop down changed");
        var finalTagString = getSelectedOptionValues(this).join(',');
        console.log(finalTagString);        
        document.getElementById('all_tags_for_UserIntrestEdit').innerHTML = finalTagString;
        
    }
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

window.userLoggedin = function(){
    if(currentuser == undefined){
        return false;
    }else{
        return true;
    }
}

//constants
var timeForNotifications = 4500;
var timeForGetMessages = 2000;

//global vars
var recFetchMsg = undefined; 
var lastmsgid = 0;
var currentuser = undefined;
var currentuserprofile = undefined;


// ready function
$(document).ready(function() {    

    //initializations
    if (document.getElementById("currentuser").innerHTML != "null") {
        currentuser = JSON.parse(document.getElementById("currentuser").innerHTML);
        currentuserprofile = JSON.parse(document.getElementById("currentuserprofile").innerHTML);
    }
    //---------

    //for new question dropdown 
    if(document.getElementById("questions_new")){
     makeNewQuestionDropDownResponsibe();
    }
    
    if(document.getElementById("user_profiles_edit_intersts")){
        makeUserIntrestEditDropDownResponsibe();
    }

    if(userLoggedin()){
        window.setInterval(function(){
            getNotifications()
          }, timeForNotifications);
    }   
    console.log("loaded application js");       
});

//on turbo linkschange function
$(document).on('turbolinks:load', function() { 

    //for question page
    if(document.getElementById("questions_new")){
        makeNewQuestionDropDownResponsibe();
    }
    //for  edit intrests in userprogiles 
    if(document.getElementById("user_profiles_edit_intersts")){
        makeUserIntrestEditDropDownResponsibe();
    }

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

   var questions_new_page = document.getElementById("questions_new");
   if(questions_new_page){
    makeNewQuestionDropDownResponsibe();
   }
   if(document.getElementById("user_profiles_edit_intersts")){
    makeUserIntrestEditDropDownResponsibe();
    }
});