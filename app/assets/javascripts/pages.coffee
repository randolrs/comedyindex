# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
		
	jQuery ->

		$(".geocomplete-input").geocomplete()

		$("#time-zone-input").set_timezone()

		$(".sticky").stick_in_parent();

		$(".vote").click (e) ->
			showID = $(@).data('show-id')
			direction = $(@).data('vote-direction')
			$.ajax
				url: "/show/vote/#{showID}/#{direction}", format: 'js'
				type: "GET"
				success: (data) ->
		  			console.log(data)
 
		$(".toggle-active").click (e) ->
			if $(@).hasClass("active")
				$(@).removeClass("active")
			else
				$(@).addClass("active")

		$(".toggle-to-activate").click (e) ->
			target_id = "#" + $(@).data("activate-input")
			if $(target_id).val() == "false"
				$(target_id).val(true)
			else
				$(target_id).val(false)

		$(".click-to-reveal").click (e) ->
			$('a.click-to-reveal').removeClass('active')
			$('div.reveal-panel').hide()
			$(@).addClass('active')
			targetId = "#" + $(@).data("reveal-panel-id")
			$('body').find(targetId).show()

		$(".password-input").focus (e) ->
			$('.button').addClass("orange-background")

		$(window).scroll (e) ->
			st = $(@).scrollTop()
			last = $('body').data('last-scroll')
			$('body').data('last-scroll', st).removeAttr('last-scroll')

		$(".click-to-toggle").click (e) ->
			targetId = "#" + $(@).data("reveal-panel-id")
			$('body').find(targetId).slideToggle()

		$(".modal-cta").click (e) ->
			targetId = "#" + $(@).data("modal-id")
			$('body').find(targetId).show()
			$('body').addClass('no-scroll')
			$('.menu-content').animate({width:'show'},350);

		$(".modal-container").click (e) ->
			$(@).hide()
			$('body').removeClass('no-scroll')
			$('.menu-content').animate({width:'hide'},350);

		$(".dismiss-modal").click (e) ->
			$(".modal-container").hide()
			$('body').removeClass('no-scroll')
			$('.menu-content').animate({width:'hide'},350);

		$(".dismiss-parent").click (e) ->
			$(@).parent().slideUp()

		$(".menu-cta").click (e) ->
			$('.menu-content').animate({width:'show'},350);

		$(".menu-modal").click (e) ->
			$('.menu-content').animate({width:'hide'},350);

		$('.menu-content').click (e) ->
			e.stopPropagation()

		$('.thumb-cta').click (e) ->
			e.stopPropagation()
			alert("get off my dick")

		$('.modal-content').click (e) ->
			e.stopPropagation()

		$('.modal-content-full').click (e) ->
			e.stopPropagation()

		$('#rating_string').change (e) ->
			$('#rating_number').val($(@).val());


$(document).on('turbolinks:load', ready)