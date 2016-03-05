class ConfirmationsController < Devise::ConfirmationsController
  # Remove the first before_action (:require_no_authentication) if you
  # want to enable logged users to access the confirmation page.
  before_action :require_no_authentication
  skip_before_action :authenticate_user_from_token!

  before_action :set_confirmable, only: :update

  # PUT /resource/confirmation
  def update
    respond_to do |format|
      if @confirmable.update(user_params)
        format.html { super }
        format.json do
          @confirmable.confirm
          @confirmable.activate!
          sign_in(resource_name, @confirmable)
          data = {
            token: @confirmable.authentication_token,
            login: @confirmable.email,
            user_id: @confirmable.id
          }
          render json: data, status: 201
        end
      else
        format.html { render action: 'edit' }
        format.json { render json: ErrorSerializer.serialize(@confirmable.errors), status: :unprocessable_entity }
      end
    end
  end

  private

    def set_confirmable
      @confirmable = User.find_or_initialize_with_error_by(:confirmation_token, params[:confirmation_token])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

end
