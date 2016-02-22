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

    initializes :user

    validates_presence_of :user

    delegate :email, to: :user

    attr_accessor :skip_setting_username_and_email

    before_validation :set_username, on: :create, unless: :skip_setting_username_and_email
    before_validation :set_user_email_from_person, unless: :skip_setting_username_and_email

    before_validation :user_concern_ensure_user_role
    before_validation :user_concern_ensure_auth_obj_type
  end

  def name
    user.username
  end

  def role_name
    user.role.name rescue nil
  end

  def confirmed?
    self.user.confirmed?
  end

  def activated?
    self.user.activated
  end

  def activate!
    user.activate!
  end

  def deactivate!
    user.deactivate!
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

  def set_username
    unless %w( stephan mike_neubert ).include?(self.user.username)
      unless self.person.lastname.nil? && self.person.firstname.nil?
        user.username = "#{person.lastname.downcase}_#{person.firstname.downcase}_#{StringRandom.new.password}"
      end
    end
  end

  def set_user_email_from_person
    user.email = person.email if person.email
  end

  # Makes sure, a role is set for this user
  module ClassMethods

    attr :user_concern_role_name

    def ensure_user_role role_name = nil, &block
      @user_concern_role_name = role_name || block
    end

  end

end
