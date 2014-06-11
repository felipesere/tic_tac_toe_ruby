module TicTacToe
  class Player

    def initialize(name)
      @name = name
    end

    def perform_move(board)
      move = select_move(board.possible_moves)
      board.perform_move(@name, move)
    end

    def select_move(moves)
      moves[ rand(moves.size) ]
    end
  end
end
