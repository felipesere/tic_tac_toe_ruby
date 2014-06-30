require 'spec_helper'

describe Game do
  it "runs" do
    human = ScriptablePlayer.new(:x, [1,2,3])
    random = ScriptablePlayer.new(:o, [4,5])
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
      board.perform_move(@name, board.move_table[@moves.shift])
    end
  end
end
