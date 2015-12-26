class LanguageSerializer < ActiveModel::Serializer
  attributes :id, :name, :native_name, :i18n_code
end
