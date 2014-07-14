require 'tic_tac_toe/board'

module TicTacToe
  module Players
    class HumanPlayer

      attr_reader :name

      def initialize(name, params)
        @name = name
        @io = params.fetch(:io)
      end

      def perform_move(board)
        moves = board.possible_moves
        value = @io.read.to_i
        if moves.include?(value)
          board.perform_move(@name, value)
        else
          @io. write "invalid input: #{value}"
          perform_move(board)
        end
      end
    end
  end
end
