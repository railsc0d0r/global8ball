class Player < ActiveRecord::Base
  has_papertrail
  
  include UserConcern
  include PersonConcern

  ensure_user_role 'Player'

  after_rollback :clean_up_associations, on: :create

  protected

  # called when saving has failed for some reason, but some of the associated
  # records may already have been persisted.
  def clean_up_associations
    user.destroy if user.try :persisted?
    person.destroy if person.try :persisted?
  end
  
end
