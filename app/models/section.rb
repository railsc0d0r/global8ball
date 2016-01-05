class Section < ActiveRecord::Base

  has_many :contents, inverse_of: :section, dependent: :destroy

end
