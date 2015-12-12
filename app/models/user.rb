# Our primary authorization-model
class User < ActiveRecord::Base
  before_save :ensure_authentication_token

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  # validates login-credentials
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
  validates :username, length: 5..50
  validate :validate_password

  before_validation :strip_empty_passwords, on: :update

  belongs_to :role

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  # overwrite devise to use email or username as login
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      # when allowing distinct User records with, e.g., "username" and "UserName"...
      where(conditions.to_hash).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
    else
      conditions[:email].downcase! if conditions[:email]
      where(conditions.to_hash).first
    end
  end

  def active_for_authentication?
    self.activated?
  end

  def activate!
    self.activated = true
    save!
  end

  def deactivate!
    self.activated = false
    save!
  end

  ## Called by devise
  def inactive_message
    :inactive
  end
  
  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def role_name
    role.try :name
  end

  def role_name= name
    self.role = Role.where(name: name).first
  end
  
  # convinience finder
  def self.find_by_login login
    where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
  end

  # convinience-methods to make code better readable
  def is_activated?
    self.activated
  end

  def auth_obj
    auth_obj_type.constantize.where(user_id: id).first if auth_obj_type
  end

  def is_admin?
    self.role.name == 'Administrator'
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

  def validate_password
    return if password.nil? || password.blank?
    errors.add :password, :must_be_different_from_email if password == email
    errors.add :password, :must_be_different_from_username if password == username
    errors.add :password, :must_not_be_this if PASSWORD_BLACKLIST[password]
    return errors[:password].empty?
  end

  def strip_empty_passwords
    self.password = nil if password && password.blank?
    self.password_confirmation = nil if password_confirmation && password_confirmation.blank?
  end

  # Needed for declarative authorization
  def available_roles
    roles = Role.all.map!{|r| r.name}
    roles.delete self.role.name

    roles
  end

  def role_symbols
    self.has_no_role? ? [] : [self.role.name.underscore.to_sym]
  end
  
  
end
