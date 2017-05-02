class LocationPromptsController < ApplicationController
  before_action :set_location_prompt, only: [:show, :edit, :update, :destroy]

  # GET /location_prompts
  # GET /location_prompts.json
  def index
    @location_prompts = LocationPrompt.all
  end

  # GET /location_prompts/1
  # GET /location_prompts/1.json
  def show
  end

  # GET /location_prompts/new
  def new
    @location_prompt = LocationPrompt.new
  end

  # GET /location_prompts/1/edit
  def edit
  end

  # POST /location_prompts
  # POST /location_prompts.json
  def create
    @location_prompt = LocationPrompt.new(location_prompt_params)

    respond_to do |format|
      if @location_prompt.save
        format.html { redirect_to @location_prompt, notice: 'Location prompt was successfully created.' }
        format.json { render :show, status: :created, location: @location_prompt }
      else
        format.html { render :new }
        format.json { render json: @location_prompt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /location_prompts/1
  # PATCH/PUT /location_prompts/1.json
  def update
    respond_to do |format|
      if @location_prompt.update(location_prompt_params)
        format.html { redirect_to @location_prompt, notice: 'Location prompt was successfully updated.' }
        format.json { render :show, status: :ok, location: @location_prompt }
      else
        format.html { render :edit }
        format.json { render json: @location_prompt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /location_prompts/1
  # DELETE /location_prompts/1.json
  def destroy
    @location_prompt.destroy
    respond_to do |format|
      format.html { redirect_to location_prompts_url, notice: 'Location prompt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location_prompt
      @location_prompt = LocationPrompt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_prompt_params
      params.require(:location_prompt).permit(:address, :message, :cta_text, :cta_link, :latitude, :longitude)
    end
end
