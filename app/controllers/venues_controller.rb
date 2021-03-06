class VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :edit, :update, :destroy]

  # GET /venues
  # GET /venues.json
  def index
    @venues = Venue.all
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
  end

  # GET /venues/new
  def new
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit
  end

  def show_with_url

    if Venue.where(:url_slug => params[:url_slug]).exists?

      @venue = Venue.find_by_url_slug(params[:url_slug])

      @main_SEO_title = @venue.name

      @SEO_description = @venue.about

      @nav_return = true
      

    else

      redirect_to root_path

    end

  end


  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.new(venue_params)

    respond_to do |format|
      
      if @venue.save

        original_slug = @venue.name.downcase.gsub(' ', '-')

        slug = original_slug
        
        c=0
        i=1

        until c==1 do

          unless Venue.where(:url_slug => slug).exists?

            @venue.update(:url_slug => slug)

            c=1

          else

            i = i + 1

            slug = original_slug + "-" + i.to_s

          end

        end


        format.html { redirect_to @venue, notice: 'Venue was successfully created.' }
        format.json { render :show, status: :created, location: @venue }
      else
        format.html { render :new }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  def update
    respond_to do |format|
      if @venue.update(venue_params)
        format.html { redirect_to @venue, notice: 'Venue was successfully updated.' }
        format.json { render :show, status: :ok, location: @venue }
      else
        format.html { render :edit }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    @venue.destroy
    respond_to do |format|
      format.html { redirect_to venues_url, notice: 'Venue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_params
      params.require(:venue).permit(:city_id, :address_line_1, :address_line_2, :city, :market_id, :state_province, :name, :about, :image, :twitter_url, :facebook_url, :instagram_url, :youtube_url, :snapchat_url, :website_url, :address, :latitude, :longitude, :url_slug)
    end
end
