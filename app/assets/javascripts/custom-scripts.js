


/* tooltips */
$(function() {
$('.tooltip-link').tooltip();
});

/* select-forms */

jQuery(document).ready(function(){
var params = {
		changedEl: "select.cusel",
		visRows: 10,
		scrollArrows: true
	}
	cuSel(params);
});

jQuery(".cusel").each(function(){
	var w = parseInt($(this).width()),
	    scrollPanel = $(this).find(".cusel-scroll-pane");
	if(w>=scrollPanel.width())
	{
	    $(this).find(".jScrollPaneContainer").width(w);
	    scrollPanel.width(w);
	}
	$(this).find('.cusel-scroll-wrap').hover(function(){
		$(this).addClass('cuselOptHover');
	}, function(){
		$(this).removeClass('cuselOptHover');
	});
});

/* form-sliders */

$('.ui-slider-handle').draggable();

$(function() {
		$( "#cabins" ).slider({
			range: "min",
			value: 28,
			min: 1,
			max: 40,
			slide: function( event, ui ) {
				$( "#cabins-amount" ).val(ui.value );
			}
		});
		$( "#cabins-amount" ).val($( "#cabins" ).slider( "value" ) );
	});
	
$(function() {
		$( "#bathrooms" ).slider({
			range: "min",
			value: 3,
			min: 1,
			max: 5,
			slide: function( event, ui ) {
				$( "#bathrooms-amount" ).val(ui.value );
			}
		});
		$( "#bathrooms-amount" ).val($( "#bathrooms" ).slider( "value" ) );
	});

$(function() {
		$( "#age" ).slider({
			range: "min",
			value: 65,
			min: 1,
			max: 150,
			slide: function( event, ui ) {
				$( "#age-amount" ).val(ui.value );
			}
		});
		$( "#age-amount" ).val($( "#age" ).slider( "value" ) );
	});
	
$(function() {
		$( "#length" ).slider({
			range: "min",
			value: 28,
			min: 1,
			max: 40,
			slide: function( event, ui ) {
				$( "#cabins-amount2" ).val(ui.value );
			}
		});
		$( "#cabins-amount2" ).val($( "#cabins2" ).slider( "value" ) );
	});


/* thumb slider */

$(document).ready(function() {
				$('#carouselh').jsCarousel({ 
				onthumbnailclick: function(src) { alert(src); },
				autoscroll: true, 
				masked: false, 		
				itemstodisplay: 6, 
				orientation: 'h' });
        	}); 

/* thumbs slider BIG */
$(document).ready(function(){

				
				$('#carousel').carouFredSel({
					responsive: true,
					circular: false,
					auto: true,
					items: {
						visible: 1,
						width: 200,
						height: '56%'
					},
					scroll: {
						fx: 'directscroll'
					}
				});

				$('#thumbs').carouFredSel({
					responsive: true,
					auto: false,
					prev: '#prev',
					next: '#next',
					items: {
						visible: {
							min: 2,
							max: 6
						},
						width: 96,
						height: '66%'
					}
				});

				$('#thumbs a').click(function() {
					$('#carousel').trigger('slideTo', '#'+this.href.split('#').pop());
					$('#thumbs a').removeClass('selected');
					$(this).addClass('selected');
					return false;
				});

			});

	/* filters block */
$(document).ready(function(){
$('#des-filters').click(function() {
	if ($('#des-filters').hasClass('hide-arrow-active')){
       $('#filters').stop(true, true).slideUp(350);
		
		$('#des-filters').removeClass('hide-arrow-active');
		$('#des-filters').addClass('hide-arrow-non-active');
		}
		else {
			$('#filters').stop(true, true).slideDown(350);
			
			$('#des-filters').removeClass('hide-arrow-non-active');
		$('#des-filters').addClass('hide-arrow-active');
		}
    });
});	







