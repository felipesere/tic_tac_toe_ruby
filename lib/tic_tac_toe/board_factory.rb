require 'tic_tac_toe/board'

module TicTacToe
  class BoardFactory
    def self.create_empty
      Board.create(Array.new(Board::SIZE) { Array.new(Board::SIZE) })
    end

    def self.create_winning_for(player)
      board = create_empty
      3.times do
        move = board.possible_moves.first
        board = board.perform_move(player, move)
      end
      board
    end
  end
end
