require 'spec_helper'

describe Game do
  it "runs" do
    human = HumanPlayer.new(:x)
    random = AiPlayer.create(:o)
    game = Game.new(human, random)
    game.start
  end
end
