class FirstBreak < OhmBaseModel
  reference :game, :Game

  attribute :owner_id, Type::Integer

  def before_save
    validate_owner
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

  def validate_owner
    raise "Owner is not valid. Has to be '#{self.round.player_one.firstname} #{self.round.player_one.lastname}' or '#{self.round.player_two.firstname} #{self.round.player_two.lastname}'" unless self.owner_id == (self.round.game.player_1_id || self.round.game.player_2_id)
  end

end
