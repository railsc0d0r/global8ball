class Shot < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes

  reference :round, :Round
  collection :positions, :Position
end
