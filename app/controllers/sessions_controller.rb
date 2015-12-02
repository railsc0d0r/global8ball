#
# Our SessionController is derived from Devise::SessionController
# We just provide token-based authentication and return JSON
#
class SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, only: :create 
  prepend_before_filter :allow_params_authentication!, only: :create
  
  def create
    respond_to do |format|
      format.html { super }
      format.json do
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        data = {
          token: self.resource.authentication_token,
          login: self.resource.email,
          user_id: self.resource.id
        }
        render json: data, status: 201
      end
    end
  end

  protected

  def sign_in_params
    devise_parameter_sanitizer.sanitize(:sign_in)
  end

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end
end
