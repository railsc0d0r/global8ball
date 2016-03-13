class BallPosition < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes

  reference :positions, :Positions
  reference :ball, :Ball
  attribute :x, Type::Float
  attribute :y, Type::Float
end
