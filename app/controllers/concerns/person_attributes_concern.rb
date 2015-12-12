#
# Contains convinience method fetching all attributes concerning a person from given hash
# and giving them back as hash.
# Needed because of nested structure of concerned models
#
module PersonAttributesConcern
  extend ActiveSupport::Concern
  include AddressAttributesConcern

  class_methods do
    def fetch_person_attributes params_hash
      raise "Given argument is not a hash" unless params_hash.class == Hash

      {
        title: params_hash.delete(:title),
        firstname: params_hash.delete(:firstname),
        lastname: params_hash.delete(:lastname),
        nickname: params_hash.delete(:nickname),
        date_of_birth: params_hash.delete(:date_of_birth),
        email: params_hash.delete(:email),
        phone: params_hash.delete(:phone),
        address_attributes: fetch_address_attributes(params_hash)
      }
    end
  end
end
