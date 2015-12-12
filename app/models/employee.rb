class Employee < ActiveRecord::Base
  include UserConcern
  include PersonConcern

  attr_accessor :skip_setting_username_and_email
  
  before_validation :set_username, on: :create, unless: :skip_setting_username_and_email
  before_validation :set_user_email_from_person, unless: :skip_setting_username_and_email

  protected

  def set_username
    unless  %w( stephan mike_neubert ).include? self.user.username
      user.username = "#{person.lastname.downcase}_#{person.firstname.downcase}_#{StringRandom.new.password}"
    end
  end

  def set_user_email_from_person
    user.email = person.email if person.email
  end

end
