#
# UserConcern
#
# Contains common behavior of objects having a `user' attached to them.
#
# This facilitates the possibility for the entity including this concern to be `authenticated'.
#
module UserConcern
  extend ActiveSupport::Concern

  included do
    belongs_to :user, dependent: :destroy

    validates_associated :user
    # The :update_only part removes the need to pass in the `id' everytime a user is updated
    # through one of the models including this concern.
    accepts_nested_attributes_for :user, update_only: true


    extend ClassMethods

    # initializes :user

    validates_presence_of :user

    delegate :email, to: :user

    after_validation :user_concern_ensure_user_role

    # TODO: has to be implemented yet.
    # after_validation :user_concern_ensure_auth_obj_type
  end

  def name
    user.username
  end

  def role_name
    user.role.name rescue nil
  end

  def activated
    self.user.activated
  end

  def activate!
    user.activate!
  end

  def deactivate!
    user.deactivate!
  end

  ## FIXME: I'm not sure if this is a good pattern. It surely is convenient though :)
  def site_id= site_id
    user.site_id = site_id
  end

  def game_sessions
    user.game_sessions
  end

  def rounds
    user.rounds
  end

  protected

  def user_concern_ensure_user_role
    role_name = self.class.user_concern_role_name
    role_name = instance_eval(&role_name) if role_name.is_a? Proc
    user.role_name = role_name if role_name && user
  end

  def user_concern_ensure_auth_obj_type
    user.auth_obj_type = self.class.name if user
  end

  # Makes sure, a role is set for this user
  module ClassMethods

    attr :user_concern_role_name

    def ensure_user_role role_name = nil, &block
      @user_concern_role_name = role_name || block
    end

  end

end
