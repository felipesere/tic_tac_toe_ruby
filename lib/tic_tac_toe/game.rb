require 'spec_helper'

module TicTacToe
  class Game
    def initialize(interface, first_player, second_player)
      @player = [first_player, second_player]
      @interface = interface 
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
      if board.has_winner?
        @interface.message_winner(@player.first.name)
      else
        @interface.message_draw
      end
    end
  end
end
