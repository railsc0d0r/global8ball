class Person < ActiveRecord::Base

  has_one :address, dependent: :destroy

  accepts_nested_attributes_for :address

  validates :address, presence: true, associated: true
  validate :validate_date_of_birth

  # initializes :address

  protected

  def validate_date_of_birth
    if date_of_birth && date_of_birth > 18.years.ago
      errors.add :date_of_birth, :too_young
    end
  end
  
end
