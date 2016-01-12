class Role < ActiveRecord::Base

  has_paper_trail

  has_many :users, inverse_of: :role
  
end
