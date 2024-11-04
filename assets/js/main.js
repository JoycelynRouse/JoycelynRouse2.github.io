/*
	Dopetrope by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
*/

(function($) {

	var	$window = $(window),
		$body = $('body');

	// Breakpoints.
		breakpoints({
			xlarge:  [ '1281px',  '1680px' ],
			large:   [ '981px',   '1280px' ],
			medium:  [ '737px',   '980px'  ],
			small:   [ null,      '736px'  ]
		});

	// Play initial animations on page load.
		$window.on('load', function() {
			window.setTimeout(function() {
				$body.removeClass('is-preload');
			}, 100);
		});

		$(window).on('scroll', function() {
			var scrollTop = $(this).scrollTop();
			$('#header').css({
				backgroundPosition: 'center ' + (scrollTop * 0.5) + 'px'
			});
		});
 $window.on('scroll', function() {
    const scrollTop = $window.scrollTop();
    
    // Background scroll effect
    $('#header').css({
        backgroundPosition: 'center ' + (scrollTop * 0.5) + 'px'
    });

    // Animate banner header on scroll
    const bannerOffset = $('#banner').offset().top;
    if (scrollTop > bannerOffset - $window.height() + 100) {
        $('#banner header').css({
            opacity: 1,
            transform: 'translateY(0)',
            transition: 'opacity 0.5s ease-out, transform 0.5s ease-out'
        });
    } else {
        $('#banner header').css({
            opacity: 0,
            transform: 'translateY(20px)'
        });
    }
});

	// Dropdowns.
		$('#nav > ul').dropotron({
			mode: 'fade',
			noOpenerFade: true,
			alignment: 'center'
		});

	// Nav.

		// Title Bar.
			$(
				'<div id="titleBar">' +
					'<a href="#navPanel" class="toggle"></a>' +
				'</div>'
			)
				.appendTo($body);

		// Panel.
			$(
				'<div id="navPanel">' +
					'<nav>' +
						$('#nav').navList() +
					'</nav>' +
				'</div>'
			)
				.appendTo($body)
				.panel({
					delay: 500,
					hideOnClick: true,
					hideOnSwipe: true,
					resetScroll: true,
					resetForms: true,
					side: 'left',
					target: $body,
					visibleClass: 'navPanel-visible'
				});

})(jQuery);