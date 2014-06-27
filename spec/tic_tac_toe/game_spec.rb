require 'spec_helper'

describe Game do

  let(:player)   { Player.create(:x) }
  let(:opponent) { RandomPlayer.new(:o) }

  it "should run" do
    game = Game.new(player, opponent)
    game.start
    expect(game.is_finished?).to be true
    expect(game.winner).to be :x
  end
end
