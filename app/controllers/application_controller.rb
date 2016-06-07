class ApplicationController < ActionController::Base
  include ErrorSerializer

  before_action :authenticate_user_from_token!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_paper_trail_whodunnit
  before_action :store_request_details
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  # Include helper from Global8ballGame
  helper Global8ballGame::GameHelper

  def index
    render layout: false
  end

  rescue_from CanCan::AccessDenied do |exception|
    error_object = { errors: [
                      {title: t(:access_denied)}
                    ] }
    respond_to do |format|
      format.html { redirect_to root_url, notice: exception.message }
      format.json { render json: error_object, status: :forbidden }
    end
  end

  private

  def store_request_details
    RequestStore.store[:protocol] = request.protocol
    RequestStore.store[:host] = request.host == 'localhost' ? request.host : ENV['domain']
    RequestStore.store[:port] = request.port
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :terms_and_conditions) }
    devise_parameter_sanitizer.permit(:confirmation) { |u| u.permit(:confirmation_token) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  def authenticate_user_from_token!
    # TODO: Workaround because warden still stores the last user.
    # Investigate and fix this
    sign_out

    token = request.headers['Auth-Token'].presence
    login = request.headers['Auth-Login'].presence
    user = login && User.find_by_login(login)

    if user && Devise.secure_compare(user.authentication_token, token)
      sign_in user, store: false
    end
  end
end
