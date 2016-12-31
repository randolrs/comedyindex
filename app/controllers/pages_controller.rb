class PagesController < ApplicationController

	def home

			
		if user_signed_in?

			redirect_to dashboard_path

		end

	end


	def dashboard

		unless user_signed_in?

			redirect_to login_path

		end


	end


	
	def signup

		@hide_header = true

		@hide_footer = true

	end

	def login

		@hide_header = true

		@hide_footer = true
		
	end


	def community


	end

	def update_market

		session[:market] = Market.find(params[:market_data][:market_id])

		redirect_to :back

	end


end
