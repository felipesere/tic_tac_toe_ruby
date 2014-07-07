require 'tic_tac_toe/board'

module TicTacToe
  module Players
    class HumanPlayer
      def initialize(name, interface=CliInterface.new)
        @name = name
        @interface = interface
      end

      def perform_move(board)
        moves = board.move_table
        value = @interface.read_user_input.to_i
        if moves.include?(value)
          board.perform_move(@name, moves[value])
        else
          @interface.input_error(value)
          perform_move(board)
        end
      end
    end
  end
end
