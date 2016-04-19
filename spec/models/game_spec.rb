require 'rails_helper'

RSpec.describe Game, :type => :model do
  context "With two players joining a game" do
    FactoryGirl.create(:role, name: 'Player')
    player1 = FactoryGirl.create(:player)
    player2 = FactoryGirl.create(:player)

    it "Validates that the two players are not the same" do
      game = Game.new
      game.player_one = player1

      expect(game.player_two = player1).to raise_error
    end
  end
end
