// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


$(document).ready(function(){
    function getNotifs(){
        $.get("/reminders?r=" + new Date().getTime(),function(data){
            $.each(data,function(index){
                $.notify({
                    message: "<strong>Upcoming Task</strong>  <br/>"+ this.content
                },{
                    type: 'info',
                    newest_on_top: true
                });
            });
            console.log(data);
        });
        $.get("/notifications?r=" + new Date().getTime(),function(data){
            $.each(data,function(index){
                $.notify({
                    message: "<strong>New Task</strong> <br/>" + this.content
                },{
                    type: 'success',
                    newest_on_top: true
                });
            });
            console.log(data);
        });
    }
    if(window.logged_in) {
        getNotifs();
        setInterval(getNotifs, 5000);
    }
});