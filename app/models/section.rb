class Section < ActiveRecord::Base

  has_paper_trail

  has_many :contents, inverse_of: :section, dependent: :destroy

end
