module TicTacToe
  class Player
    def self.create(name)
      me = Player.new(name)
      opponent = Player.new(name == :x ? :o : :x)
      me.set_opponent(opponent)
      opponent.set_opponent(me)
      me
    end

    def initialize(name)
      @name = name
      @cache = {}
    end

    def set_opponent(opponent)
      @opponent = opponent
    end

    def perform_move(board)
      move = select_move(board)
      board.perform_move(@name, move)
    end

    def select_move(board)
      move ||= @cache[board.generate_key]
      move ||= winning_move(board)
      move ||= defending_move(board)
      move ||= next_best_alternative(board)
      @cache[board.generate_key]=move
      move
    end

    def winning_move(board)
      board.possible_moves.find do |move|
        new_board = board.perform_move(@name, move)
        new_board.has_winner?
      end
    end

    def defending_move(board)
      @opponent.winning_move(board)
    end

    def next_best_alternative(board)
      move_value = lambda { |pair| pair[0] }

      board.possible_moves.map { |move| [value_of_move(board, move), move] }.sort_by { move_value }.last[1]
    end

    def value_of_move(board, move)
      new_board = board.perform_move(@name, move)

      if new_board.has_draw?
        0
      elsif new_board.has_winner?
        10
      else
        opponent_move = @opponent.select_move(new_board)
        -@opponent.value_of_move(new_board, opponent_move)
      end
    end
  end
end
