// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function () {
	$("#checkDate").datetimepicker({
    	format:'YYYY-MM-DD'
    });

	$("#gau").click(function(){
		window.location = "/avalable_users/" + $("#checkDate").val();
	});
});