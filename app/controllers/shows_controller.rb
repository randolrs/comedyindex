class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy]

  # GET /shows
  # GET /shows.json
  def index

    #NEED TO MAKE "MY SHOWS" LATER

    if user_signed_in?
      
      if current_user.is_admin
        @shows = Show.all
      else
        redirect_to root_path
      end

    else
      redirect_to root_path
    end
  end

  def dashboard
    
    @market_object = Market.find_by_short_name(params[:market_name])
    @shows = @market_object.shows
    @city = @market_object.name
    @show_dashboard_view = true
    @time_period = "Any Day"
    @price_description = "Any Price"
    @show_type = "Any Type"

    @nav_return = true
    @nav_return_title = @city + " Comedy Shows"

  end

  def show_tag_index

    @show_tag = ShowTag.where(:url_slug => params[:url_slug]).last

    #had params[:market_name], need to get @show_occurrences for that

    input_location = params[:market_name]
    @market = Market.where(:short_name => input_location.downcase).last


    if @show_tag && @market

      #@show_occurrences = @show_tag.nearby_show_occurrences(@market.latitude, @market.longitude, Date.today, Date.tomorrow + 7)
      @SEO_title = @market.name + " " + @show_tag.name + " Comedy Shows " + Time.now.strftime("%Y")
      
      @SEO_description = "Find the funniest " + @show_tag.name + " comedy shows and events in " + @market.name + "."


    else

      redirect_to root_path

    end

  end

  def index_for_review

    @review_index = true
    @market_object = Market.find(@market["id"])
    @shows = @market_object.shows
    @city = @market_object.name
    @time_period = "Anytime"
    @price_description = "Any Price"


  end

  # GET /shows/1
  # GET /shows/1.json
  def show

    @main_SEO_title = @show.name
    
  end

  def this_shows_occurrences

    #NEED TO MAKE "MY SHOWS" LATER

    if user_signed_in?
      
      if current_user.is_admin
        @show = Show.find(params[:id])

        @show_occurrences = @show.show_occurrences.order(:date)
      else
        redirect_to root_path
      end

    else
      redirect_to root_path
    end

  end

  def edit_show_occurrence

    #NEED TO MAKE "MY SHOWS" LATER

    if user_signed_in?
      
      if current_user.is_admin
        
        @show_occurrence = ShowOccurrence.find(params[:id])

        @show = Show.find(@show_occurrence.schedulable_id)

      else
        redirect_to root_path
      end

    else
      redirect_to root_path
    end


    

  end

  def update_show_occurrence

    @show_occurrence = ShowOccurrence.find(params[:id])

    @show = Show.find(@show_occurrence.schedulable_id)

    respond_to do |format|
      
      if @show_occurrence.update(show_occurrence_params)

        if @show_occurrence.title

          slug = @show_occurrence.title.downcase.gsub(' ', '-')

          @show_occurrence.update(:url_slug => slug)

        end

        ####update other occurrences
        if params[:other_occurences_to_update]
        
          params[:other_occurences_to_update].each do |occurrence_param|

            if occurrence_param[1] == "true"

              occurrence = ShowOccurrence.where(:id => occurrence_param[0]).last

              if occurrence #check for existing occurrence

                occurrence.update(:title => @show_occurrence.title, :about => @show_occurrence.about, :image => @show_occurrence.image)
                
                if occurrence.title
                  occurrence.update(:url_slug => @show_occurrence.url_slug)
                end

                #occurrence.update(show_occurrence_params)

              end

            end

          end

        end

        format.html { redirect_to this_shows_occurrences_path(@show.id), notice: 'Venue was successfully updated.' }
        #format.json { render :show, status: :ok, location: redirect_to this_shows_occurrences_path(@show.id) }
      else
        format.html { render :edit }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end


    # respond_to do |format|
    #   if @venue.update(venue_params)
    #     format.html { redirect_to @venue, notice: 'Venue was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @venue }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @venue.errors, status: :unprocessable_entity }
    #   end
    # end

  

    #@show_occurrence.update(:title => params[:title], :about => params[:about], :image => params[:image])

    #@show_occurrence.update(:title => params[:title], :about => params[:about])

    #redirect_to this_shows_occurrences_path(@show.id)

  end

  def show_with_url

    @whitebackground = false

    if ShowOccurrence.where(:id => params[:show_occurrence_id]).exists?

      @show_occurrence = ShowOccurrence.find(params[:show_occurrence_id])

      @show = Show.find(@show_occurrence.schedulable_id)



      @SEO_title = @show.name + " | " + @show_occurrence.date.strftime("%d-%b-%Y") + " | " + @show.city

      @SEO_description = @show.about

      #@SEO_description = @show.name + " is a live comedy show in " + @show.city + " on " + @show_occurrence.date.strftime("%d-%b-%Y") + " at " +  @show_occurrence.date.strftime("%l:%M%P") + "."



      @nav_return = true

    else

      redirect_to root_path

    end


  end



  def show_home


    if Show.where(:url_slug => params[:url_slug]).exists?

      @show = Show.find_by_url_slug(params[:url_slug])

      @main_SEO_title = @show.name

      @SEO_description = @show.about

      @nav_return = true


      #@nav_return_title = @show.name

    else

      redirect_to root_path

    end


  end


  # GET /shows/new
  def new
    if user_signed_in?
      @show = Show.new
    else
      redirect_to root_path
    end
  end

  # GET /shows/1/edit
  def edit
  end

  # POST /shows
  # POST /shows.json
  def create
    
    if user_signed_in?

      @show = Show.new(show_params)

      respond_to do |format|
        
        if @show.save

          params[:tags].each do |tag|

            show_tag = ShowTag.where(:name => tag[0]).last

            if show_tag

              #check for existing show tag entry

              show_tag_entry = ShowTagEntry.where(:show_id => @show.id, :show_tag_id => show_tag.id).last

              if tag[1] == "true"  #if selected

                unless show_tag_entry

                  ShowTagEntry.create(:show_tag_id => show_tag.id, :show_id => @show.id, :is_active => true)

                else

                  show_tag_entry.update(:is_active => true)

                end



              else #if not selected

                if show_tag_entry

                  show_tag_entry.update(:is_active => false)

                end

              end

            end

          end

          original_slug = @show.name.downcase.gsub(' ', '-')

          slug = original_slug
          
          c=0
          i=1

          until c==1 do

            unless Show.where(:url_slug => slug).exists?

              @show.update(:url_slug => slug)

              c=1

            else

              i = i + 1

              slug = original_slug + "-" + i.to_s

            end

          end


          unless @show.producer_id

            @show.update(:producer_id => current_user.id, :user_id => current_user.id)

          end

          #ShowOccurence.create(:show_id => @show.id, :start_time => @show.start_time)

          unless @show.venue_id

            unless @show.address.blank? or @show.venue_name.blank?

              venue = Venue.create(:address => @show.address, :name => @show.venue_name, :user_id => current_user.id)

              @show.update(:venue_id => venue.id)

              # Add URL SLUG TO VENUE
              original_slug = venue.name.downcase.gsub(' ', '-')

              slug = original_slug
              
              c=0
              i=1

              until c==1 do

                unless Venue.where(:url_slug => slug).exists?

                  venue.update(:url_slug => slug)

                  c=1

                else

                  i = i + 1

                  slug = original_slug + "-" + i.to_s

                end

              end

              # END URL SLUG FOR VENUE

            end

          else

            @show.update(:address => @show.venue.address, :venue_name => @show.venue.name)

          end

          these_show_occurrences =  ShowOccurrence.where(:schedulable_id => @show.id)
          these_show_occurrences.update_all(:address => @show.address, :latitude => @show.latitude, :longitude => @show.longitude, :show_id => @show.id)
          next_show_occurrence = these_show_occurrences.first

          format.html { redirect_to show_with_url_path(@show.city, next_show_occurrence.check_for_url_slug, next_show_occurrence.date.strftime("%e-%b-%Y"), next_show_occurrence.id), notice: 'Show was successfully created.' }
          format.json { render :show, status: :created, location: @show }
        else
          format.html { render :new }
          format.json { render json: @show.errors, status: :unprocessable_entity }
        end
      end

    else

      redirect_to root_path
    end

  end

  # PATCH/PUT /shows/1
  # PATCH/PUT /shows/1.json
  def update
    respond_to do |format|
      if @show.update(show_params)

       params[:tags].each do |tag|

          show_tag = ShowTag.where(:name => tag[0]).last

          if show_tag #is this a real show_tag?

            show_tag_entry = ShowTagEntry.where(:show_id => @show.id, :show_tag_id => show_tag.id).last

            if tag[1] == "true" #if selected

              unless show_tag_entry

                ShowTagEntry.create(:show_tag_id => show_tag.id, :show_id => @show.id, :is_active => true)

              else

                show_tag_entry.update(:is_active => true)

              end


            else #if not selected

              if show_tag_entry

                show_tag_entry.update(:is_active => false)

              end

            end

          end

        end

        format.html { redirect_to show_home_path(@show.city, @show.url_slug), notice: 'Show was successfully updated.' }
        format.json { render :show, status: :ok, location: @show }
      else
        format.html { render :edit }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shows/1
  # DELETE /shows/1.json
  def destroy
    @show.destroy
    respond_to do |format|
      format.html { redirect_to shows_url, notice: 'Show was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_show
      @show = Show.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def show_params
      params.require(:show).permit(:name, :market_id, :venue_id, :website_url, :category_1_id, :category_2_id, :about, :address_line_1, :address_line_2, :city, :state_province, :country, :image, :address, :start_time, :time_zone, :venue_name, :video_url, :video_description, :reason_we_recommend, :is_secret_show, show_occurences_attributes:[:start_time], schedule_attributes: Schedulable::ScheduleSupport.param_names)
    end

    def show_occurrence_params
      params.require(:show_occurrence).permit(:image, :title, :about, :date, :video_url, :video_description, :reason_we_recommend, :address)
    end
end
