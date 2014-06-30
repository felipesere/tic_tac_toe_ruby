require 'spec_helper'

module TicTacToe
  class Game
    def initialize(first, second)
      @player = [first, second]
      @interface = CliInterface.new
    end

    def start
      board = Board.create_empty

      turns = 0
      until board.has_winner? or board.has_draw? do
        @interface.render(board)
        board = @player[turns % 2].perform_move(board)
        turns += 1
      end

      puts "Final board:"
      @interface.render(board)
    end
  end
end
