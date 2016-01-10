
$(document).ready(function(){
// on click, have the selected post open up in a modal at the center of the page for editing
	$('.acpostsi').on('click', function(){	
		$(this).find('div').show().animate({
			right: '38%',
			'height': '215px',
		});
		$('.accmodal').fadeIn(200);
	});

	$('.navbar2').hover(function(){
		$(this).css('color', 'grey');
		}, function(){
		$(this).css('color', 'black');
	});


	$(".flashNotice").fadeOut(2500);

	// $(".flashNotice2").hide(2500);
	// $(".flashNotice2").fadeIn(2500);

$('.flashNotice2').hide().fadeIn(2500)

});



