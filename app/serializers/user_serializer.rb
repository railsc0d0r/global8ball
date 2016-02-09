class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :role_name, :auth_obj_type, :auth_obj_id

  def role_name
    object.role.try :name
  end

  def auth_obj_id
    object.auth_obj.try :id
  end
end
