class Collision < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes

  attribute :user_id, Type::Integer
end
