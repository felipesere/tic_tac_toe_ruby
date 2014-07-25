require 'tic_tac_toe/board'
require 'pp'

# see: http://www.iis.sinica.edu.tw/~tshsu/tcg2012/slides/slide7.pdf
module TicTacToe
  module Players
    class FastAiPlayer
      attr_reader :players
      attr_reader :name

      def initialize(name, params)
        opponent_mark = name == :x ? :o : :x 
        @players = [name , opponent_mark ]
        @name = name
      end

      def perform_move(board)
        move = select_move(board)
        board.perform_move(@name, move)
      end

      def ready?
        true
      end

      def select_move(board)
        best_move = nil
        best_score = -Float::INFINITY
        board.possible_moves.shuffle.each do |move|
          new_board = board.perform_move(players.first, move)
          score =  -alpha_beta(new_board, -Float::INFINITY , Float::INFINITY, players.rotate)
          if score > best_score
            best_move, best_score =  move, score
          end
        end
        best_move
      end

      def alpha_beta(board, alpha, beta, players)
        if board.is_finished?
          value_of_board(board, players.first)
        else
          calculate_best_score(board, alpha, beta, players)
        end
      end

      def calculate_best_score(board, alpha, beta, players)
        score = alpha
        board.possible_moves.each do |move|  
          new_board = board.perform_move(players.first, move)
          score = -alpha_beta(new_board, -beta, -alpha, players.rotate)
          alpha = [alpha, score].max
          break if alpha >= beta
        end
        alpha
      end

      def value_of_board(board, player)
        if board.is_winner?(player)
          board.value
        else
          -board.value
        end
      end
    end
  end
end
