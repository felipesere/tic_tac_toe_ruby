require 'spec_helper'

describe Game do

  let(:interface) { FakeInterface.new }

  it "end when a player wins with three in a row" do
    first_player = ScriptablePlayer.new(:x, [1,2,3])
    second_player = ScriptablePlayer.new(:o, [4,5])
   
    interface.expect_winner(:x)

    run_game(first_player, second_player)
  end

  it "end with a draw between both player" do
    first_player = ScriptablePlayer.new(:x, [1,2,6,7,9])
    second_player = ScriptablePlayer.new(:o, [4,5,3,8])
   
    interface.expect_draw
    run_game(first_player, second_player)
  end
 
  def run_game(first_player, second_player)
    game = Game.new(interface, first_player, second_player)
    game.start
  end

  class ScriptablePlayer
    attr_reader :name
    def initialize(name, moves)
      @name = name
      @moves = moves
    end

    def perform_move(board)
      board.perform_move(@name, board.move_table[@moves.shift])
    end
  end
end
