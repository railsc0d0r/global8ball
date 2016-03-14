class PlayerSerializer < ActiveModel::Serializer
  require 'concerns/person_serializer_concern'
  require 'concerns/address_serializer_concern'
  
  include PersonSerializerConcern
  include AddressSerializerConcern
  
  attributes :id,
             :firstname,
             :lastname,
             :username,
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
             :country,
             :id_type,
             :id_number

  def username
    object.user.username
  end
end
