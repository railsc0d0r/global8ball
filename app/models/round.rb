class Round < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes

  reference :game, :Game
  collection :events, :Event
end
