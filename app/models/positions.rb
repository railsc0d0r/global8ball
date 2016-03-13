class Positions < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes

  collection :ball_positions, :BallPosition
end
