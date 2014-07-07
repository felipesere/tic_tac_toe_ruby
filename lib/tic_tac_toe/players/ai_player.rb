require 'tic_tac_toe/board'

module TicTacToe
  module Players
    class AiPlayer

      attr_reader :name

      def self.create(name)
        me = AiPlayer.new(name)
        opponent = AiPlayer.new(name == :x ? :o : :x)
        me.set_opponent(opponent)
        opponent.set_opponent(me)
        me
      end

      def initialize(name)
        @name = name
      end

      def set_opponent(opponent)
        @opponent = opponent
      end

      def perform_move(board)
        move = select_move(board)
        board.perform_move(@name, move)
      end

      def select_move(board)
        cache(board.generate_key) do 
          move ||= winning_move(board)
          move ||= defending_move(board)
          move ||= next_best_alternative(board)
        end
      end

      def cache(key, &block)
        @cache ||= {}
        move ||= @cache[key]
        move ||= block.call
        @cache[key]=move
        move
      end

      def winning_move(board)
        board.possible_moves.find do |move|
          board.perform_move(@name, move).has_winner?
        end
      end

      def defending_move(board)
        @opponent.winning_move(board)
      end

      def next_best_alternative(board)
        board.possible_moves.sort_by do |move|
          value_of_move(board, move)
        end.last
      end

      def value_of_move(board, move)
        new_board = board.perform_move(@name, move)
        if new_board.has_draw?
          0
        elsif new_board.has_winner?
          10.0 / new_board.possible_moves.size
        else
          opponent_move = @opponent.select_move(new_board)
          -@opponent.value_of_move(new_board, opponent_move)
        end
      end
    end
  end
end
