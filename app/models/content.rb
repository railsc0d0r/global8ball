class Content < ActiveRecord::Base

  belongs_to :section, inverse_of: :contents
  belongs_to :language, inverse_of: :contents

  validates_presence_of :section, :language

end
