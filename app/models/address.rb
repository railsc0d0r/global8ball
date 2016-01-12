class Address < ActiveRecord::Base
  has_papertrail
  
  belongs_to :person
end
