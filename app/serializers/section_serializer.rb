class SectionSerializer < ActiveModel::Serializer
  attributes :id, :path

  has_many :contents

  def contents
    object.contents.pluck :id
  end
end
