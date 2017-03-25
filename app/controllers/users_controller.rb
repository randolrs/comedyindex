class UsersController < ApplicationController
  
  respond_to :html, :js

  def account_settings
  end

  def comic_signup

  	@main_SEO_title = "Comics Signup"

  end

  def producer_signup

  	@main_SEO_title = "Producer Signup"

  end

  def venue_signup

  	@main_SEO_title = "Venue Signup"

  end

  def dashboard

  	@main_SEO_title = "Dashboard"

  end

  def profile

    @user = User.where(:first_name => params[:display_name]).last

  end

  def vote

    # respond_to do |format|
    #   format.js { render json: { :status => "success", :now_following => false } , content_type: 'text/json' }
    # end


    respond_to do |format|
      format.js {}
      format.json { render json:  }
      format.html { render action: 'index' }
    end
 end


    # respond_to do |format|
    #   format.js { render json: { :status => "success", :now_following => false } , content_type: 'text/json' }
    # end


    #if user_signed_in?

      # if params[:showID] && params[:direction]

      #   @show = Show.where(:id => params[:showID]).first        

      #   if @show

      #     @vote = ShowVote.where(user_id: current_user.id, show_id: @show.id).first

      #     unless @vote

      #       @vote = Vote.create(:user_id => current_user.id, :show_id => @show.id)

      #     end

      #     if params[:direction] == "up"
            
      #       @vote.upvote

      #       respond_to do |format|
      #         format.js { render json: { :status => "success"} , content_type: 'text/json' }
      #       end
          
      #     elsif params[:direction] == "down"
            
      #       @vote.downvote

      #       respond_to do |format|
      #         format.js { render json: { :status => "success"} , content_type: 'text/json' }
      #       end

      #     else

      #       respond_to do |format|
      #         format.js { render json: { :status => "failure", :notice => "invalid direction"} , content_type: 'text/json' }
      #       end

      #     end

      #   else

      #     respond_to do |format|
      #       format.js { render json: { :status => "failure", :notice => "no such show"} , content_type: 'text/json' }
      #     end

      #   end

      # else

      #   respond_to do |format|
      #     format.js { render json: { :status => "failure"} , content_type: 'text/json' }
      #   end


      # end
      # XXYYZZ
      # respond_to do |format|
      #       render json: { :change => -1, :notice=> "signed in", content_type: 'text/json' }
      #       #format.js { render json: { :status => "success", :notice => "signed in"} , content_type: 'text/json' }
      # end

    #else
      # YYRREE
      # respond_to do |format|
      #   render json: { :change => -1, :notice=> "not signed in", content_type: 'text/json' }
      #   #format.js { render json: { :status => "success", :notice => "not signed in"} , content_type: 'text/json' }
      # end

      # respond_to do |format|
      #   format.html { redirect_to signup_path, notice: 'Show was successfully created.' }
      #   #format.json { render :show, status: :created, location: @show }
      #   #format.js { render json: { :status => "failure"} , content_type: 'text/json' }
      # end

    #end

  end
  
end
