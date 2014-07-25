require 'digest'

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
      raise InvalidMoveError < StandardError unless valid_move? move
      new_board = elements.dup
      index = move-1
      new_board[index] = name.to_sym
      Board.new(slice(new_board))
    end

    def slice(board)
      board.each_slice(SIZE).to_a
    end
    
   def valid_move?(move)
     possible_moves.include? move
   end

    def marked?(row, column)
      !@places[row][column].nil?
    end

    def is_finished?
      has_winner? || has_draw?
    end

    def value
      @value ||= calculate_value
    end

    def calculate_value
      if has_draw?
        0
      else
        10.0 / possible_moves.size
      end
    end

    def has_draw?
      !has_winner? && possible_moves.empty?
    end

    def has_winner?
      @has_winner ||= (is_winner?(:x) || is_winner?(:o))
    end

    def winner
      winner = lines.find { |line| line.uniq.size == 1 }.uniq.first
    end

    def is_winner?(name)
      lines.any? { |line| line == [name, name, name] }
    end

    def lines
      @lines ||= (rows + columns + diagonals)
    end

    def rows
      @places
    end

    def columns
      @places.transpose
    end

    def diagonals
       [
        (0...SIZE).collect{|i| @places[i][i]}, 
        (0...SIZE).collect{|i| @places[i][SIZE-i-1] }
      ]
    end

    def elements
      @places.flatten
    end

    def to_s
      elements.map do |element|
        element.nil? ? "_" : element 
      end.join.to_s
    end
  end
end
