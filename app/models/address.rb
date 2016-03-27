class Address < ActiveRecord::Base

  has_paper_trail
  
  belongs_to :person

  validates :city, :country, presence: true

end
