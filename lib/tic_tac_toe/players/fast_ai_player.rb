require 'tic_tac_toe/board'

module TicTacToe
  module Players
    class ABPruningPlayer
      attr_reader :players
      attr_reader :name
      def initialize(name)
        @players = [name , name == :x ? :o : :x ]
        @name = name
      end

      def perform_move(board)
        move = select_move(board)
        board.perform_move(@name, move)
      end

      def select_move(board)
        alpha = -Float::INFINITY
        beta = Float::INFINITY

        best_move = nil
        best_score = -Float::INFINITY
        board.possible_moves.shuffle.each do |move|
          new_board = board.perform_move(players.first, move)
          score =  -alpha_beta(new_board, alpha, beta, players.rotate)
          if score > best_score
            best_move, best_score =  move, score
          end
        end
        best_move
      end

      def alpha_beta(board, alpha, beta, players)
        if is_terminal_board(board)
          value_of_board(board, players.first)
        else
          best_score = alpha 
          board.possible_moves.shuffle.each do |move|  
            new_board = board.perform_move(players.first, move)
            score = -alpha_beta(new_board, -beta, -best_score, players.rotate)
            best_score = [score, best_score].max 
            alpha = [alpha, best_score].max
            break if alpha >= beta
          end
          best_score
        end
      end

      def is_terminal_board(board)
        board.has_winner? || board.has_draw?
      end
      
      def value_of_board(board, player)
        if board.has_draw?
          return 0
        end
        if board.is_winner?(player)
          board.possible_moves.size
        else
          -board.possible_moves.size
        end
      end
    end
  end
end
