class CountrySerializer < ActiveModel::Serializer
  attributes :id, :name, :code, :language
end
