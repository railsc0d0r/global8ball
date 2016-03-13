class Event < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes

  reference :round, :Round

  attribute :type
end
