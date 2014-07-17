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
        value = @input
        puts value
        if moves.include?(value)
          board.perform_move(@name, value)
        else
          @io. write "invalid input: #{value}"
          perform_move(board)
        end
      end
      
      def ready?
        @input = @io.read
        !@input.nil?
      end
    end
  end
end
