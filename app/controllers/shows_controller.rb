class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy]

  # GET /shows
  # GET /shows.json
  def index
    @shows = Show.all
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


    if @show_tag

      @show_occurrences = @show_tag.nearby_show_occurrences(session[:latitude], session[:longitude], Date.today, Date.tomorrow + 7)

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

  def show_with_url

    @whitebackground = false


    if Show.where(:url_slug => params[:url_slug]).exists?

      @show = Show.find_by_url_slug(params[:url_slug])

      @main_SEO_title = @show.name

      @SEO_description = @show.about

      @nav_return = true

      if ShowOccurrence.where(:id => params[:show_occurrence_id]).exists?

        @show_occurrence = ShowOccurrence.find(params[:show_occurrence_id])

      else

        redirect_to root_path
        
      end


      #@nav_return_title = @show.name

    else

      redirect_to root_path

    end


  end

  # GET /shows/new
  def new
    @show = Show.new
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

              if tag[1]  

                #if selected

                unless show_tag_entry

                  ShowTagEntry.create(:show_tag_id => show_tag.id, :show_id => @show.id, :is_active => true)

                else

                  show_tag_entry.update(:is_active => true)

                end



              else

                #if not selected

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

            end

          else

            @show.update(:address => @show.venue.address, :venue_name => @show.venue.name)

          end


          ShowOccurrence.where(:schedulable_id => @show.id).update_all(:address => @show.address, :latitude => @show.latitude, :longitude => @show.longitude)
          

          format.html { redirect_to show_with_url_path(@show.city, @show.url_slug), notice: 'Show was successfully created.' }
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

          if show_tag

            #check for existing show tag entry

            show_tag_entry = ShowTagEntry.where(:show_id => @show.id, :show_tag_id => show_tag.id).last

            if tag[1] #if selected

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

        format.html { redirect_to show_with_url_path(@show.url_slug), notice: 'Show was successfully updated.' }
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
      params.require(:show).permit(:name, :market_id, :venue_id, :website_url, :category_1_id, :category_2_id, :about, :address_line_1, :address_line_2, :city, :state_province, :country, :image, :address, :start_time, :time_zone, :venue_name, show_occurences_attributes:[:start_time], schedule_attributes: Schedulable::ScheduleSupport.param_names)
    end
end
