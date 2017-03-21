class UsersController < ApplicationController
  
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
  
end
