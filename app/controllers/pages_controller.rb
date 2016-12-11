class PagesController < ApplicationController

	def home

			
		if user_signed_in?

			redirect_to dashboard_path

		end

	end


	def dashboard



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
