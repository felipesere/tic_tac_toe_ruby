require 'spec_helper'

module TicTacToe
  class Game
    def initialize(interface, first_player, second_player)
      @player = [first_player, second_player]
      @interface = interface 
    end

    def start
      greeting
      final_board, final_player = play
      result(final_board, final_player)
    end

    def play
      board = Board.create_empty
      turns = 0
      until board.has_winner? or board.has_draw? do
        @interface.render(board)
        board = @player[turns % 2].perform_move(board)
        turns += 1
      end
      turns += 1
      [board, @player[turns % 2]]
    end

    def greeting
      @interface.message("Hello! You are X. Enjoy!")
    end

    def result(board, last_player)
      puts "Final board:"
      @interface.render(board)
      if board.has_winner?
        @interface.message_winner(last_player.name)
      else
        @interface.message_draw
      end
    end
  end
end
