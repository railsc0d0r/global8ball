class SectionSerializer < ActiveModel::Serializer
  attributes :id, :path, :background

  has_many :contents

  def contents
    object.contents.pluck :id
  end

  def background
    object.background.url(:large) unless object.background.url(:large) == "/backgrounds/large/missing.png"
  end
end
