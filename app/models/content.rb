class Content < ActiveRecord::Base

  has_papertrail
  
  belongs_to :section, inverse_of: :contents

  validates_presence_of :section, :language

end
