class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :check_for_location

  def check_for_location

    session[:market] = Market.find(1)


  end




  def after_sign_in_path_for(user)

    if user_signed_in?

    	if current_user.is_comic


    		setup_performer_profile_path

    	else

        root_path

      end

    else

      root_path

    end


  end


  def after_sign_out_path_for(user)
      root_path
  end


  def configure_permitted_parameters

    registration_params = [:email, :password, :is_comic, :is_producer, :is_venue, :password]
    devise_parameter_sanitizer.permit(:sign_up, keys: registration_params)
    devise_parameter_sanitizer.permit(:sign_in, keys: registration_params)
    devise_parameter_sanitizer.permit(:account_update, keys: registration_params)
  
  end


end
