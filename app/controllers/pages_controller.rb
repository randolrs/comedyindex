class PagesController < ApplicationController

	def home

		redirect_to city_search_path("Montreal")

		@message = "HEYYY"
		
		@shows = Show.paginate(page: params[:page], per_page: 2).order('created_at DESC')
	

		unless session[:city].blank?
			
			@show_occurrences = ShowOccurrence.order(:date).nearby_show_occurrences(session[:latitude], session[:longitude], Time.current.beginning_of_day + 6.hours, Time.current.end_of_day + 6.hours + 8.days)
			
			@location_prompt = LocationPrompt.near([session[:latitude], session[:longitude]], 50).last
		
			@SEO_title = session[:city] + " Comedy Shows " + Time.now.strftime("%Y")

			@SEO_description = session[:city] + " - Find the funniest comedy shows and events in " + session[:city]

		else

			@city = nil

		end

		respond_to do |format|
    
    		format.html
    		format.js

  		end

	end


	def dashboard

		


	end

	
	def about


	end


	
	def signup

		@hide_header = true

		@hide_footer = true

		@darkbluebackground = true

	end

	def login

		@hide_header = true

		@hide_footer = true

		@darkbluebackground = true
		
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

	def update_city_link

		if params[:location]

			input_location = params[:location]

			coordinates = Geocoder.coordinates(input_location)
			
			city = Geocoder.search(coordinates).first.city

			session[:coordinates] = coordinates

			session[:city] = city

			session[:latitude] = session[:coordinates][0]

			session[:longitude] = session[:coordinates][1]

			
			if user_signed_in?

				#default city or something

			end

		end
		
		redirect_to root_path

	end

	def update_city
		if params[:location]

			input_location = params[:location]

			coordinates = Geocoder.coordinates(input_location)
			
			if coordinates
			
				city = Geocoder.search(coordinates).first.city

				session[:coordinates] = coordinates

				session[:city] = city

				session[:latitude] = session[:coordinates][0]

				session[:longitude] = session[:coordinates][1]

			
				if user_signed_in?

					#default city or something

				end

			end

		end

		#session[:city] = nil

		redirect_to :back


	end

	def show_tag_index

	    @show_tag = ShowTag.where(:url_slug => params[:url_slug]).last

	    if @show_tag
			
			@show_occurrences = @show_tag.nearby_show_occurrences(session[:latitude], session[:longitude], Time.current.beginning_of_day + 6.hours, Time.current.end_of_day + 6.hours + 8.days)
	    	@SEO_title = session[:city] + " " + @show_tag.name + " Comedy Shows " + Time.now.strftime("%Y")
	    	
	    	@SEO_description = session[:city] + " - Find the funniest " + @show_tag.name + " comedy shows and events in " + session[:city] + "."

	    else

	      redirect_to root_path

	    end

  	end

  	def comedian_contact_form

  	end

  	def comedian_contact_submissions

  	end

  	def comedian_contact_submit
  		
  		ComedianContactSubmission.create(:email => params[:email], :twitter_url => params[:twitter_url], :facebook_url => params[:facebook_url])

  		redirect_to root_path

  	end

	def search

		if params[:market_name]

			input_location = params[:market_name]

			@market = Market.where(:short_name => input_location.downcase).last

			
			if @market

		      #@show_occurrences = @show_tag.nearby_show_occurrences(@market.latitude, @market.longitude, Date.today, Date.tomorrow + 7)
		     	@show_occurrences = ShowOccurrence.order(:date).nearby_show_occurrences(@market.latitude, @market.longitude, Time.current.beginning_of_day + 6.hours, Time.current.end_of_day + 6.hours + 8.days)
				@location_prompt = LocationPrompt.near([@market.latitude, @market.longitude], 50).last
				
				@SEO_title = @market.name + " Comedy Shows " + Time.now.strftime("%Y")

				@SEO_description = @market.name + " - Find the funniest comedy shows and events in  " + @market.name + "."


		    else

		      redirect_to root_path

		    end


			# coordinates = Geocoder.coordinates(input_location)
			
			# city = Geocoder.search(coordinates).first.city

			# session[:coordinates] = coordinates

		end



	end



end
