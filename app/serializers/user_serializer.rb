class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email

  def role_name
    object.role.try :name
  end
end
