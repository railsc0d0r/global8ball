class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :role_name

  def role_name
    object.role.try :name
  end
end
