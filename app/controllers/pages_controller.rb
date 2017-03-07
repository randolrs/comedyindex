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
		
		market_id = params[:market_data][:market_id]
		@market = Market.find(market_id)
		
		if user_signed_in?

			current_user.update(:default_market_id => market_id)

		end

		session[:market] = Market.find(market_id)

		session[:location_is_unset] = false

		if params[:dashboard_refresh]
			
			redirect_to show_dashboard_path(@market["short_name"])

		else

			redirect_to :back

		end


	end


end
