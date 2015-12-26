class Language < ActiveRecord::Base

  has_many :contents, inverse_of: :language

  validates_presence_of :name, :native_name
  validates_uniqueness_of :name

end
