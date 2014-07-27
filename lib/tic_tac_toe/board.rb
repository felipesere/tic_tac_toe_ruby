module TicTacToe
  class Board
    SIZE = 3
    def initialize(places)
      @places = places
    end

    def self.create_empty
      Board.new(Array.new(SIZE) { Array.new(SIZE) })
    end

    def possible_moves
      @moves ||= elements.each.with_index(1).map do |element, index| 
        if element.nil?
          index
        end
      end.compact
    end

    def perform_move(name, move)
      raise InvalidMoveError, "#{move}" unless valid_move? move
      new_board = elements.dup
      index = move-1
      new_board[index] = name.to_sym
      Board.new(slice(new_board))
    end

    def valid_move?(move)
      possible_moves.include? move
    end

    def has_winner?
      @has_winner ||= (is_winner?(:x) || is_winner?(:o))
    end

    def has_draw?
      !has_winner? && possible_moves.empty?
    end

    def is_finished?
      has_winner? || has_draw?
    end

    def is_winner?(name)
      lines.any? { |line| line == [name, name, name] }
    end

    def value
      @value ||= calculate_value
    end

    def elements
      @places.flatten
    end

    def rows
      @places
    end

    def winner
      lines.find { |line| line.uniq.size == 1 }.uniq.first
    end
    

    private

    def slice(board)
      board.each_slice(SIZE).to_a
    end

    def calculate_value
      if has_draw?
        0
      else
        possible_moves.size + 1
      end
    end

    def lines
      @lines ||= (rows + columns + diagonals)
    end

    def columns
      @places.transpose
    end

    def diagonals
      [ (0...SIZE).collect{|i| @places[i][i]}, 
        (0...SIZE).collect{|i| @places[i][SIZE-i-1] }
      ]
    end
  end

  class InvalidMoveError < StandardError
  end
end
