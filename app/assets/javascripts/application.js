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
//= require jquery-ui/datepicker
//= require turbolinks
//= require_tree .
//= require materialize
//= require filterrific/filterrific-jquery

$(document).ready(function() {
	$('select').material_select();
	// fixed filter bar on right
    // $('.tabs-wrapper .row').pushpin({ top: $('.tabs-wrapper').offset().top });
    
    // datepicker for filter on bins index page
	$( ".datepicker" ).datepicker();

});

$(".button-collapse").sideNav();
$( document ).ready(function() { 
	$(".dropdown-button").dropdown(); 
});

$(document).ready(function(){
    $('.tooltipped').tooltip({delay: 50});
    $('.close').click(function(){
    	$(this).parent().hide();
    })
 });

// upon resize: display filter bar on top instead of right side
$(window).on('resize', function(){
	if($(window).width() < 600){
		$('.small-filter-box > div').addClass('filter-box');
	}
	else{
		$('.small-filter-box > div').removeClass('filter-box');
	}
});

