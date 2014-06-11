module TicTacToe
  class Player

    def initialize(name)
      @name = name
    end

    def perform_move(board)
      move = select_move(board)
      board.perform_move(@name, move)
    end

    def select_move(board)
      board.possible_moves.each do |move|
        new_board = board.perform_move(@name, move)
        return move if new_board.has_winner?
      end
      board.possible_moves.first
    end
  end
end
