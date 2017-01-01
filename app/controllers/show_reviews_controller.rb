class ShowReviewsController < ApplicationController
  before_action :set_show_review, only: [:show, :edit, :update, :destroy]

  # GET /show_reviews
  # GET /show_reviews.json
  def index
    @show_reviews = ShowReview.all
  end

  # GET /show_reviews/1
  # GET /show_reviews/1.json
  def show
  end

  # GET /show_reviews/new
  def new
    
    if user_signed_in?
      
      @show_review = ShowReview.new

      if params[:show_id]

        if Show.where(:id => params[:show_id]).exists?

          @show = Show.find(params[:show_id])

        end


      end

    else

      redirect_to login_path

    end



  end


  def new_with_show_header

    if user_signed_in?

      @show_review = ShowReview.new

      if params[:show_id]

        if Show.where(:id => params[:show_id]).exists?

          @show = Show.find(params[:show_id])

        end


      end

    else

      flash[:login_prompt] = "Login or Signup to write your review."
      redirect_to login_path 

    end





  end


  # GET /show_reviews/1/edit
  def edit
  end

  # POST /show_reviews
  # POST /show_reviews.json
  def create
    
    if user_signed_in?

      @show_review = ShowReview.new(show_review_params)

      @show_review.update(:user_id => current_user.id)

    else

      redirect_to root_path

    end

    respond_to do |format|
      if @show_review.save
        format.html { redirect_to @show_review, notice: 'Show review was successfully created.' }
        format.json { render :show, status: :created, location: @show_review }
      else
        format.html { render :new }
        format.json { render json: @show_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /show_reviews/1
  # PATCH/PUT /show_reviews/1.json
  def update
    respond_to do |format|
      if @show_review.update(show_review_params)
        format.html { redirect_to @show_review, notice: 'Show review was successfully updated.' }
        format.json { render :show, status: :ok, location: @show_review }
      else
        format.html { render :edit }
        format.json { render json: @show_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /show_reviews/1
  # DELETE /show_reviews/1.json
  def destroy
    @show_review.destroy
    respond_to do |format|
      format.html { redirect_to show_reviews_url, notice: 'Show review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_show_review
      @show_review = ShowReview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def show_review_params
      params.require(:show_review).permit(:show_id, :show_occurence_id, :title, :body, :rating, :author_id)
    end
end
