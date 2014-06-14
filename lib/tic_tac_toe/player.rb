module TicTacToe
  class Player
      
     def initialize(name, oponent = nil)
       @name = name
       @cache = {}
       @opponent = oponent
     end

     def create(name)
        oponent = Player.new(name == :x ? :y : :x)
        Player.new(name, oponent)
     end


     def perform_move(board)
       move = select_move(board, @name)
       board.perform_move(@name, move)
     end

     def select_move(board, player)
       move ||= @cache[board.generate_key]
       move ||= winning_move(board, player)
       move ||= defending_move(board, player)
       move ||= next_best_alternative(board, player)
       @cache[board.generate_key]=move
       move
    end

    def winning_move(board, player)
      board.possible_moves.find do |move|
        new_board = board.perform_move(player, move)
        new_board.has_winner?
      end
    end

    def defending_move(board, player)
      winning_move(board, switch_player(player))
    end

    def next_best_alternative(board, player)
      move_value = lambda { |pair| pair[0] }
      
      board.possible_moves.map do |move|
        [value_of_move(board, move, player), move]
      end.sort_by { move_value }.last[1]
    end

    def value_of_move(board, move, player)
      new_board = board.perform_move(player, move)

      if new_board.has_draw?
        0
      elsif new_board.has_winner?
        player == @name ? 10 : -10
      else
        opponent = switch_player(player) 
        opponent_move = select_move(new_board, opponent)
        value_of_move(new_board, opponent_move, opponent)
      end
    end

    def switch_player(player)
      player == :x ? :o : :x
    end
  end
end
