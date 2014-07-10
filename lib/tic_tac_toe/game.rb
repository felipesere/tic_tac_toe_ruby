require 'tic_tac_toe/board'

module TicTacToe
  class Game
    
    attr_reader :current_board
    
    def initialize(first_player, second_player)
      @player = [first_player, second_player]
      @current_board = Board.create_empty
    end

    def is_finished?
      @current_board.is_finished? 
    end

    def tick
      @current_board = play_turn
      @player.rotate!
    end

    def play_turn
      @player.first.perform_move(@current_board)
    end
  end
end
