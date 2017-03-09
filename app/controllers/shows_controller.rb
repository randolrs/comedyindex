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

      @show.url_slug = @show.name.downcase.gsub(' ', '-')

      respond_to do |format|
        if @show.save

          unless @show.producer_id

            @show.update(:producer_id => current_user.id, :user_id => current_user.id)

          end

          ShowOccurence.create(:show_id => @show.id, :start_time => @show.start_time)

          format.html { redirect_to @show, notice: 'Show was successfully created.' }
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
        format.html { redirect_to @show, notice: 'Show was successfully updated.' }
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
      params.require(:show).permit(:name, :market_id, :venue_id, :website_url, :category_1_id, :category_2_id, :about, :address_line_1, :address_line_2, :city, :state_province, :country, :image, :start_time, :venue_name, show_occurences_attributes:[:start_time])
    end
end
