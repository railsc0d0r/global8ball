class Role < ActiveRecord::Base
  has_papertrail
  
  has_many :users, inverse_of: :role
  
end
