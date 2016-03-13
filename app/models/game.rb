class Game < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes
  include Ohm::Callbacks

  collection :rounds, :Round

  attribute :player_1_id, Type::Integer
  attribute :player_2_id, Type::Integer

  def before_save
    validate_uniqueness_of_players
  end

  def player_one
    Player.find(player_1_id)
  end

  def player_one= player
    raise "Given object is not of class Player" unless player.is_a?(Player)
    self.player_1_id=player.id
    self.save
  end

  def player_two
    Player.find(player_2_id)
  end

  def player_two= player
    raise "Given object is not of class Player" unless player.is_a?(Player)
    self.player_2_id=player.id
    self.save
  end

  private

  def validate_uniqueness_of_players
    raise "Player one and player two can't be the same" if self.player_1_id == self.player_2_id
  end

end
