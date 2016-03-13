class Position < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes

  reference :shot, :Shot
  reference :ball, :Ball
  attribute :x, Type::Float
  attribute :y, Type::Float
end
