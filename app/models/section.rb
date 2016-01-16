class Section < ActiveRecord::Base

  has_paper_trail

  has_attached_file :background, styles: { large: "1400x1050>", thumb: "100x100>" }

  validates_attachment_content_type :background, content_type: /\Aimage\/.*\Z/

  has_many :contents, inverse_of: :section, dependent: :destroy

end
