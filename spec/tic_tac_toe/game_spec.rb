require 'spec_helper'
require 'tic_tac_toe/game'
require 'tic_tac_toe/ui/fake_interface'

describe TicTacToe::Game do

  let(:interface)     { TicTacToe::UI::FakeInterface.new }
  let(:first_player)  { ScriptablePlayer.new(:x, [1,2,3]) }
  let(:second_player) { ScriptablePlayer.new(:o, [4,5]) }
  
  context "#is_finished?" do
    let(:game) {TicTacToe::Game.new( first_player, second_player)}

    it "knows if the game is not finished" do
      expect(game.is_finished?).to be false
    end

    it "knows if the game is finished" do
      5.times { game.tick }
      expect(game.is_finished?).to be true
    end
  end
  it "ends when a player wins with three in a row" do
    interface.expect_winner(:x)
    run_game(first_player, second_player)
  end

  it "ends with a draw between both player" do
    first_player  = ScriptablePlayer.new(:x, [1,2,6,7,9])
    second_player = ScriptablePlayer.new(:o, [4,5,3,8])

    interface.expect_draw
    run_game(first_player, second_player)
  end

  def run_game(first_player, second_player)
    game = TicTacToe::Game.new(first_player, second_player)
    interface.play_on(game)
  end

  class ScriptablePlayer
    attr_reader :name
    def initialize(name, moves)
      @name = name
      @moves = moves
    end

    def perform_move(board)
      board.perform_move(@name, @moves.shift)
    end
  end
end
