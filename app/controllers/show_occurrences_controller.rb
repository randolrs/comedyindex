class ShowOccurrencesController < ApplicationController
  
  #before_action :set_show, only: [:show, :edit, :update, :destroy]

  # GET /shows
  # GET /shows.json
  def index
    
  end

  # GET /shows/1
  # GET /shows/1.json
  def show

    
    
  end


  # GET /shows/new
  def new
    
  end

  # GET /shows/1/edit
  def edit
  end

  # POST /shows
  # POST /shows.json
  def create
    

  end

  # PATCH/PUT /shows/1
  # PATCH/PUT /shows/1.json
  def update
    
   
  end

  # DELETE /shows/1
  # DELETE /shows/1.json
  def destroy
    @show_occurrence.destroy
    respond_to do |format|
      format.html { redirect_to shows_url, notice: 'Show was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_show
      #@show = Show.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def show_params
      params.require(:show).permit(:name, :market_id, :venue_id, :website_url, :category_1_id, :category_2_id, :about, :address_line_1, :address_line_2, :city, :state_province, :country, :image, :address, :start_time, :time_zone, :venue_name, show_occurences_attributes:[:start_time], schedule_attributes: Schedulable::ScheduleSupport.param_names)
    end
end
