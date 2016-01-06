
$(document).ready(function(){
// on click, have the selected post open up in a modal at the center of the page for editing
	$('.acpostsi').on('click', function(){	
		$(this).find('div').show().animate({
			right: '38%',
			'height': '150px',
		});
		$('.accmodal').fadeIn(200);
	});


	$(".flashNotice").fadeOut(2500);

});



