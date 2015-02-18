class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_registration
  before_filter :configure_permitted_parameters, if: :devise_controller?

  private

  def check_registration
    if current_user && !current_user.valid?
      flash[:warning] = "Please finish your #{view_context.link_to "registration", edit_user_registration_url } before continuing.".html_safe
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) do |u| 
      u.permit(:login, :username, :email, :password, :remember_me)
    end
    devise_parameter_sanitizer.for(:sign_up) do |u| u.permit(:email, :username, :first_name, :last_name, :password, :password_confirmation, :remember_me)
    end #if action_name == 'sign_up'
    devise_parameter_sanitizer.for(:account_update) do 
      |u| 
      u.permit(:username, :email, :password, :password_confirmation, :current_password )
    end #if action_name == 'account_update'
  end
  
end
