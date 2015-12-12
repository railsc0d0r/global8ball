#
# Contains convinience method fetching all attributes concerning a address from given hash
# and giving them back as hash.
# Needed because of nested structure of concerned models
#
module AddressAttributesConcern
  extend ActiveSupport::Concern

  class_methods do
    def fetch_address_attributes params_hash
      raise "Given argument is not a hash" unless params_hash.class == Hash

      {
        street: params_hash.delete(:street),
        street2: params_hash.delete(:street2),
        zip: params_hash.delete(:zip),
        city: params_hash.delete(:city),
        region: params_hash.delete(:region),
        country: params_hash.delete(:country)
      }
    end
  end
end
