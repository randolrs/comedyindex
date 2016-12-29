# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
		
	jQuery ->

		$(".click-to-reveal").click (window.event), ->
			$('a.click-to-reveal').removeClass('active')
			$('div.reveal-panel').hide()
			$(@).addClass('active')
			targetId = "#" + $(@).data("reveal-panel-id")
			$('body').find(targetId).show()

		$(".click-to-toggle").click (window.event), ->
			targetId = "#" + $(@).data("reveal-panel-id")
			$('body').find(targetId).slideToggle()

		$(".modal-cta").click (window.event), ->
			targetId = "#" + $(@).data("modal-id")
			$('body').find(targetId).show()
			$('body').addClass('no-scroll')
			$('.menu-content').animate({width:'show'},350);

		$(".modal-container").click (window.event), ->
			$(@).hide()
			$('body').removeClass('no-scroll')
			$('.menu-content').animate({width:'hide'},350);

		$(".menu-cta").click (window.event), ->
			$('.menu-content').animate({width:'show'},350);

		$(".menu-modal").click (window.event), ->
			$('.menu-content').animate({width:'hide'},350);

		$('.menu-content').click (window.event), ->
			window.event.stopPropagation()

		$('.modal-content').click (window.event), ->
			window.event.stopPropagation()

		$('#rating_string').change (window.event), ->
			$('#rating_number').val($(@).val());


$(document).on('turbolinks:load', ready)