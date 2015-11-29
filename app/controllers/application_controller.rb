class ApplicationController < ActionController::Base
  before_filter :authenticate_user_from_token
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def index
    render layout: false
  end

  private
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :terms_and_conditions) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  def authenticate_user_from_token!
    token = request.headers['Auth-Token'].presence
    login = request.headers['Auth-Login'].presence
    user = login && User.find_by_login(login)

    if user && Devise.secure_compare(user.authentication_token, token)
      sign_in user, store: false
    end
  end
end
