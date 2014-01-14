$(document).ready(function(){
	$('#tabs_contact a').click(function(e) {
		e.preventDefault();
		var id = $(this).attr('href');
		$('.show').removeClass('show');
		$(id).addClass('show');
	});
});
