class Ball < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes
  include Ohm::Callbacks

  reference :round, :Round
  attribute :type
  attribute :owner_id , Type::Integer

  def before_save
    validate_presence_of_type
    validate_type
    validate_owner unless self.owner_id == 0
  end

  def owner
    Player.find(owner_id)
  end

  def owner= player
    raise "Given object is not of class Player" unless player.is_a?(Player)
    self.owner_id=player.id
    self.save
  end

  private

  def validate_presence_of_type
    raise "Type of ball missing." if self.type.nil?
  end

  def validate_type
    raise "Type of a ball has to be white, black, yellow or red." unless ['white', 'black', 'yellow', 'red'].include?(self.type)
  end

  def validate_owner
    raise "Owner is not valid. Has to be '#{self.round.player_one.firstname} #{self.round.player_one.lastname}' or '#{self.round.player_two.firstname} #{self.round.player_two.lastname}'" unless self.owner_id == (self.round.game.player_1_id || self.round.game.player_2_id)
  end
end
