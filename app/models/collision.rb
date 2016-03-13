class Collision < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes

  reference :shot, :Shot
  reference :ball, :Ball
  attribute :user_id, Type::Integer
end
