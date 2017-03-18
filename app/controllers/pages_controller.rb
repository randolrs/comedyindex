class PagesController < ApplicationController

	def home

		@shows = Show.paginate(page: params[:page], per_page: 2).order('created_at DESC')
		
		respond_to do |format|
    
    		format.html
    		format.js

  		end

  		

		if user_signed_in?

			redirect_to dashboard_path

		end

		if session[:city]
			
			unless session[:city] == "Select a City" or session[:city] == ""

				@city = session[:city]

			else

				@city = nil

			end

		else

			@city = nil

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


	def update_city
		
		input_location = params[:location]

		coordinates = Geocoder.coordinates(input_location)
		
		city = Geocoder.search(coordinates).first.city

		session[:coordinates] = coordinates

		session[:city] = city
		
		if user_signed_in?

			#default city or something

		end

		redirect_to :back


	end



end
