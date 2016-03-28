class EmployeeSerializer < ActiveModel::Serializer
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
             :street,
             :street2,
             :zip,
             :city,
             :region,
             :country,
             :role_name

  def username
    object.user.username
  end
end
