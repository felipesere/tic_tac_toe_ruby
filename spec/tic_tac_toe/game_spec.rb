require 'spec_helper'
require 'tic_tac_toe/game'
require 'tic_tac_toe/ui/fake_interface'
require 'pp'

describe TicTacToe::Game do

  let(:interface) { TicTacToe::UI::FakeInterface.new }

  context "#is_finished?" do
    it "knows if the game is not finished" do
      first_player = ScriptablePlayer.new(:x, [1,2,3])
      second_player = ScriptablePlayer.new(:o, [4,5])

      game = TicTacToe::Game.new( first_player, second_player)
      expect(game.is_finished?).to be false
    end

    it "knows if the game is finished" do
      first_player = ScriptablePlayer.new(:x, [1,2,3])
      second_player = ScriptablePlayer.new(:o, [4,5])

      game = TicTacToe::Game.new( first_player, second_player)
      interface.expect_winner(:x)
      interface.play_on(game) 
      expect(game.is_finished?).to be true
    end
  end
  it "ends when a player wins with three in a row" do
    first_player = ScriptablePlayer.new(:x, [1,2,3])
    second_player = ScriptablePlayer.new(:o, [4,5])

    interface.expect_winner(:x)
    run_game(first_player, second_player)
  end

  it "ends with a draw between both player" do
    first_player = ScriptablePlayer.new(:x, [1,2,6,7,9])
    second_player = ScriptablePlayer.new(:o, [4,5,3,8])

    interface.expect_draw
    run_game(first_player, second_player)
  end

  def run_game(first_player, second_player)
    game = TicTacToe::Game.new( first_player, second_player)
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
