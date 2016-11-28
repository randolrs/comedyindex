class PagesController < ApplicationController

	def home

		
	end
	
	def signup

		@hide_header = true

		@hide_footer = true

	end

	def login

		@hide_header = true

		@hide_footer = true
		
	end
end
