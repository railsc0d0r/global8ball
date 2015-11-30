class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email

  belongs_to :role
  
  def role_name
    object.role.try :name
  end
end
