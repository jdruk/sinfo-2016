$(document).ready(function(){
	

	/*  Foundation Init    */
	$(document).foundation();


	/*    Mean navigation menu scroll to    */
    $('#scroll ul li a').click(function(e){
    	e.preventDefault();
    	scrollTo($(this).attr('href'), 900, 'easeInOutCubic');
    });






    /*    Back to top button    */
    var back_top = $('#back_top');

    back_top.click(function(e){
    	e.preventDefault();
    	scrollTo(0, 900, 'easeInOutCubic');
    	
    });

    function scrollTo(target, speed, ease){
    	$(window).scrollTo(target, speed, {easing:ease});
    }

    $(window).on('scroll', function(){    
	    if($(this).scrollTop()>749)
	    {
	    	back_top.stop().animate({opacity : 1}, 250);
	    }else
	    {
	    	back_top.stop().animate({opacity : 0}, 250);	    
	    }   
    });

});