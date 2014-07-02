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
      until board.has_winner? or board.has_draw? do
        board = play_turn(board)
        @player.rotate!
      end
      [board, @player.rotate!.first]
    end

    def play_turn(board)
      @interface.render(board)
      @player.first.perform_move(board)
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
