class Player < ActiveRecord::Base

  has_paper_trail

  include UserConcern
  include PersonConcern

  ensure_user_role 'Player'

  after_rollback :clean_up_associations, on: :create

  validates_presence_of :id_number, :id_type, :date_of_birth
  validate :validate_date_of_birth

  protected

  # called when saving has failed for some reason, but some of the associated
  # records may already have been persisted.
  def clean_up_associations
    user.destroy if user.try :persisted?
    person.destroy if person.try :persisted?
  end
  
  def validate_date_of_birth
    if date_of_birth && date_of_birth > 18.years.ago
      errors.add :date_of_birth, :too_young
    end
  end

end
