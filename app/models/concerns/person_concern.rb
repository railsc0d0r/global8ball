#
# PersonConcern
#
# Contains common behavior of all objects that have a `person' attached to them.
#
#
module PersonConcern
  extend ActiveSupport::Concern

  included do
    belongs_to :person, dependent: :destroy
    has_one :address, through: :person
    validates_associated :person
    accepts_nested_attributes_for :person, update_only: true

    # initializes :person

    validates_presence_of :person

    delegate :firstname, :lastname, to: :person
  end
end
