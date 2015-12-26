class ContentSerializer < ActiveModel::Serializer
  attributes :id, :headline, :content, :section_id, :language_id
end
