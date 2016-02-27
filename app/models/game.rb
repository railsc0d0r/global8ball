class Game < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes

  collection :rounds, :Round
end
