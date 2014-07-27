module TicTacToe
  module Players
    class RandomPlayer

      attr_reader :name

      def initialize(name, params)
        @name = name
      end

      def perform_move(board)
        move = board.possible_moves.sample
        board.perform_move(@name, move)
      end

      def ready?
        true
      end
    end
  end
end
