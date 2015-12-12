class EmployeeSerializer < ActiveModel::Serializer
  include PersonConcern
  include AddressConcern
  
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
