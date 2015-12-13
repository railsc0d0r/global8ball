class EmployeeSerializer < ActiveModel::Serializer
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
             :role_name
end
