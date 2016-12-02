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

		$(".modal-cta").click (window.event), ->
			targetId = "#" + $(@).data("modal-id")
			$('body').find(targetId).show()

		$(".modal-container").click (window.event), ->
			$(@).hide()

$(document).on('turbolinks:load', ready)