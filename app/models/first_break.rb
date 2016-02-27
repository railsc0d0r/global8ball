class FirstBreak < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes

  reference :game, :Game
end
