module TicTacToe
  class Player

    def initialize(name)
      @name = name
    end

    def perform_move(board)
      move = select_move(board, @name)
      board.perform_move(@name, move)
    end

    def select_move(board, player)
      move ||= winning_move(board, player)
      move ||= defending_move(board, player)
      move ||= board.possible_moves.first 
    end

    def defending_move(board, player)
      winning_move(board, switch_player(player))
    end

    def winning_move(board, player)
      board.possible_moves.find do |move|
        new_board = board.perform_move(player, move)
        new_board.has_winner?
      end
    end

    def switch_player(player)
      player == :x ? :y : :x
    end
  end
end
