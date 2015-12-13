module AddressSerializerConcern
  extend ActiveSupport::Concern

  included do
    def street
      object.address.street
    end

    def street2
      object.address.street2
    end

    def zip
      object.address.zip
    end

    def city
      object.address.city
    end

    def region
      object.address.region
    end

    def country
      object.address.country
    end
  end
end
