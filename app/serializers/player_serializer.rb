class PlayerSerializer < ActiveModel::Serializer
  include PersonSerializerConcern
  include AddressSerializerConcern
  
  attributes :id,
             :firstname,
             :lastname,
             :nickname,
             :title,
             :email,
             :phone,
             :date_of_birth,
             :street,
             :street2,
             :zip,
             :city,
             :region,
             :country
end
