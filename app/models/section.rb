class Section < ActiveRecord::Base

  has_papertrail
  
  has_many :contents, inverse_of: :section, dependent: :destroy

end
