class ConfirmationsController < Devise::ConfirmationsController
  # Remove the first skip_before_filter (:require_no_authentication) if you
  # don't want to enable logged users to access the confirmation page.
  skip_before_filter :require_no_authentication
  skip_before_filter :authenticate_user_from_token!

  # PUT /resource/confirmation
  def update
    with_unconfirmed_confirmable do
      if @confirmable.has_no_password?
        @confirmable.attempt_set_password(params[:user])
        if @confirmable.valid? and @confirmable.password_match?
          do_confirm
        else
          do_show
          @confirmable.errors.clear #so that we wont render :new
        end
      else
        @confirmable.errors.add(:email, :password_already_set)
      end
    end

    if !@confirmable.errors.empty?
      self.resource = @confirmable
      respond_to do |format|
        format.html { render html: @confirmable }
        format.json { render json: ErrorSerializer.serialize(@confirmable.errors), status: :unprocessable_entity }
      end
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    with_unconfirmed_confirmable do
      if @confirmable.has_no_password?
        do_show
      else
        do_confirm
      end
    end
    unless @confirmable.errors.empty?
      self.resource = @confirmable
      respond_to do |format|
        format.html { render html: @confirmable }
        format.json { render json: ErrorSerializer.serialize(@confirmable.errors), status: :unprocessable_entity }
      end
    end
  end

  protected

  def with_unconfirmed_confirmable
    @confirmable = User.find_or_initialize_with_error_by(:confirmation_token, params[:confirmation_token])
    if !@confirmable.new_record?
      @confirmable.only_if_unconfirmed {yield}
    end
  end

  def do_show
    @confirmation_token = params[:confirmation_token]
    @requires_password = true
    self.resource = @confirmable
    respond_to do |format|
      format.html { render html: @confirmable }
      format.json { render json: @confirmable }
    end
  end

  def do_confirm
    @confirmable.confirm!
    sign_in(resource_name, @confirmable)
    data = {
      token: @confirmable.authentication_token,
      login: @confirmable.email,
      user_id: @confirmable.id
    }
    render json: data, status: 201
  end
end
