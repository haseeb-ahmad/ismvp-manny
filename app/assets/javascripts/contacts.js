$(document).ready(function(){
	
	//$(".tabify").hide();
	//$(".tabify").eq(0).show();

	$( "#tabs_contact a" ).click(function(){
		var id = $(this).attr('id');
		$(".tabify").hide();
		$(".active-tab").hide();
		$(id).show();
	});

	$( "#contact_page" ).click(function(){
		//window.location = ;
	});
});
