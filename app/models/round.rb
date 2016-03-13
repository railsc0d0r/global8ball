class Round < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes

  reference :game, :Game
  collection :balls, :Ball
  collection :shots, :Shot
end
