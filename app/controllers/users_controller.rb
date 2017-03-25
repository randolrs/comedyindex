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


    if user_signed_in?

      if params[:showID] && params[:direction]

        @show = Show.where(:id => params[:showID]).first        

        if @show

          @vote = ShowVote.where(user_id: current_user.id, show_id: @show.id).first

          unless @vote

            @vote = ShowVote.create(:user_id => current_user.id, :show_id => @show.id)

          end

          if params[:direction] == "up"
          
            @vote.upvote

            render json: { :result => "success", :notice=> "upvote", content_type: 'text/json' }


          elsif params[:direction] == "down"
            
            @vote.downvote

            render json: { :result => "success", :notice=> "downvote", content_type: 'text/json' }


          end

        else

          render json: { :result => "failure", :notice=> "invalid show", content_type: 'text/json' }

        end

      else

        render json: { :result => "failure", :notice=> "invalid parameters", content_type: 'text/json' }

      end

       

    else

       render :js => "window.location = '/signup'"

    end

  end
  
end
