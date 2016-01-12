class Content < ActiveRecord::Base

  has_paper_trail
  
  belongs_to :section, inverse_of: :contents

  validates_presence_of :section, :language

end
