require 'tic_tac_toe/board'

module TicTacToe
  module Players
    class HumanPlayer
      attr_reader :name
      attr_reader :io

      def initialize(name, params)
        @name = name
        @io = params.fetch(:io)
      end

      def perform_move(board)
        choice = io.read.to_i
        select(board, choice)
      end
      
      def select(board, choice)
        if board.valid_move?(choice)
          board.perform_move(name, choice)
        else
          invalid_move(board, choice)
        end
      end

      def invalid_move(board, choice)
        io.write "invalid input: #{choice}"
        perform_move(board)
      end

      def ready?
        io.ready?
      end
    end
  end
end
