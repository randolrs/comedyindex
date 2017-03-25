# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
		
	jQuery ->

		$(".geocomplete-input").geocomplete()

		$("#time-zone-input").set_timezone()

		$(".sticky").stick_in_parent();

		$(".vote").click (window.event), ->
			showID = $(@).data('show-id')
			direction = $(@).data('vote-direction')
			alert("Show" + showID)
			alert("Direction" + direction)
			if $(@).data('vote-direction') == "up"
				alert("up")
				$.ajax
				url: "/show/vote/#{showID}/#{direction}", format: 'js'
				type: "GET"
				success: (data) ->
			  		console.log(data)
			  		alert("successful up")
			else if $(@).data('vote-direction') == "down"
				alert("down")
 
		$(".toggle-active").click (window.event), ->
			if $(@).hasClass("active")
				$(@).removeClass("active")
			else
				$(@).addClass("active")

		$(".click-to-reveal").click (window.event), ->
			$('a.click-to-reveal').removeClass('active')
			$('div.reveal-panel').hide()
			$(@).addClass('active')
			targetId = "#" + $(@).data("reveal-panel-id")
			$('body').find(targetId).show()

		$(".password-input").focus (window.event), ->
			$('.button').addClass("orange-background")

		$(window).scroll (window.event), ->
			st = $(@).scrollTop()
			last = $('body').data('last-scroll')
			$('body').data('last-scroll', st).removeAttr('last-scroll')
			if st > last
			else

		$(".click-to-toggle").click (window.event), ->
			targetId = "#" + $(@).data("reveal-panel-id")
			$('body').find(targetId).slideToggle()

		$(".modal-cta").click (window.event), ->
			targetId = "#" + $(@).data("modal-id")
			$('body').find(targetId).slideDown()
			$('body').addClass('no-scroll')
			$('.menu-content').animate({width:'show'},350);

		$(".modal-container").click (window.event), ->
			$(@).hide()
			$('body').removeClass('no-scroll')
			$('.menu-content').animate({width:'hide'},350);

		$(".dismiss-modal").click (window.event), ->
			$(".modal-container").hide()
			$('body').removeClass('no-scroll')
			$('.menu-content').animate({width:'hide'},350);

		$(".dismiss-parent").click (window.event), ->
			$(@).parent().slideUp()

		$(".menu-cta").click (window.event), ->
			$('.menu-content').animate({width:'show'},350);

		$(".menu-modal").click (window.event), ->
			$('.menu-content').animate({width:'hide'},350);

		$('.menu-content').click (window.event), ->
			window.event.stopPropagation()

		$('.thumb-cta').click (window.event), ->
			window.event.stopPropagation()
			alert("get off my dick")

		$('.modal-content').click (window.event), ->
			window.event.stopPropagation()

		$('.modal-content-full').click (window.event), ->
			window.event.stopPropagation()

		$('#rating_string').change (window.event), ->
			$('#rating_number').val($(@).val());


$(document).on('turbolinks:load', ready)