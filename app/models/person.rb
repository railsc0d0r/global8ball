class Person < ActiveRecord::Base

  has_paper_trail

  has_one :address, dependent: :destroy

  accepts_nested_attributes_for :address

  validates :address, presence: true, associated: true
  validates :firstname, :lastname, presence: true

  initializes :address
end
