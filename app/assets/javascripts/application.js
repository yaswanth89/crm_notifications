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
//= require bootstrap-sprockets
//= require moment
//= require bootstrap-datetimepicker
//= require turbolinks
//= require private_pub
//= require_tree .


$(document).ready(function(){
	if(!!window.user_id){
        PrivatePub.subscribe("/messages/" + window.user_id, function(data, channel) {
            console.log(data);
            $.notify({
             	message: "<strong>" + data.head + "</strong> <br/>" +  data.content,
                url:data.url
            },{
             	type: data.theme,
                newest_on_top: true
            });
        });
	}
});