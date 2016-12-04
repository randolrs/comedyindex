class PerformersController < ApplicationController
  before_action :set_performer, only: [:show, :edit, :update, :destroy]

  # GET /performers
  # GET /performers.json
  def index
    @performers = Performer.all
  end

  # GET /performers/1
  # GET /performers/1.json
  def show

    @main_SEO_title = @performer.name
    
  end

  def setup_profile
    @performer = Performer.new
  end

  # GET /performers/new
  def new
    @performer = Performer.new
  end

  # GET /performers/1/edit
  def edit
  end

  # POST /performers
  # POST /performers.json
  def create
    
    if user_signed_in?
    
      @performer = Performer.new(performer_params)

      respond_to do |format|
        
        if @performer.save

          if current_user.is_comic

            @performer.update(:user_id => current_user.id)

            current_user.update(:performer_id => @performer.id)

          end

          format.html { redirect_to @performer, notice: 'Performer was successfully created.' }
          format.json { render :show, status: :created, location: @performer }
        else
          format.html { redirect_to :back }
          format.json { render json: @performer.errors, status: :unprocessable_entity }
        end

      end

    else

      redirect_to root_path

    end



  end

  # PATCH/PUT /performers/1
  # PATCH/PUT /performers/1.json
  def update
    respond_to do |format|
      if @performer.update(performer_params)
        format.html { redirect_to @performer, notice: 'Performer was successfully updated.' }
        format.json { render :show, status: :ok, location: @performer }
      else
        format.html { render :edit }
        format.json { render json: @performer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /performers/1
  # DELETE /performers/1.json
  def destroy
    @performer.destroy
    respond_to do |format|
      format.html { redirect_to performers_url, notice: 'Performer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_performer
      @performer = Performer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def performer_params
      params.require(:performer).permit(:name, :bio, :city, :country, :twitter_url, :facebook_url, :instagram_url, :youtube_url, :snapchat_url, :website_url, :video_url, :image)
    end
end
