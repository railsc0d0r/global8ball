class Collision < OhmBaseModel
  reference :shot, :Shot
  reference :ball, :Ball
  attribute :user_id, Type::Integer
end
