module TicTacToe
  module Players
    class RandomPlayer

      attr_reader :name

      def initialize(name)
        @name = name
      end

      def perform_move(board)
        board.perform_move(@name, board.possible_moves.sample)
      end
    end
  end
end
