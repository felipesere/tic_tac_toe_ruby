module TicTacToe
  module Players
    class HumanPlayer

      def initialize(name)
        @name = name
        @interface = CliInterface.new
      end

      def perform_move(board)
        move = @interface.get_move(board)
        board.perform_move(:x, move)
      end
    end
  end
end
