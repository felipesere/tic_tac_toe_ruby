require 'spec_helper'

describe Game do
  it "runs" do
    human = ScriptablePlayer.new(:x, [0,1,2])
    random = ScriptablePlayer.new(:o, [3,4])
    game = Game.new(human, random)
    game.start
  end

  class ScriptablePlayer
    attr_reader :name
    def initialize(name, moves)
      @name = name
      @moves = moves
    end

    def perform_move(board)
      index = @moves.shift
      board.perform_move(@name, board.possible_moves[index])
    end
  end
end
