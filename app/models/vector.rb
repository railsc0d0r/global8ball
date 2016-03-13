class Vector < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes

  reference :event, :Event

  attribute :start_x, Type::Float
  attribute :start_y, Type::Float
  attribute :end_x, Type::Float
  attribute :end_y, Type::Float
end
