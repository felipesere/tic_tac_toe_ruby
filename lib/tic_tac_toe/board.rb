require 'digest'

module TicTacToe
  class Board

    SIZE = 3

    def initialize(places)
      @places = places
    end

    def self.create_empty
      Board.create(Array.new(SIZE) { Array.new(SIZE) })
    end

    def self.create(board)
      board.each_index do |row|
        board[row].each_index do |column|
          add_move(board, row, column)
        end
      end
      Board.new(board)
    end

    def self.add_move(board, row, column)
      if board[row][column] == nil 
        board[row][column] = Move.new(row: row, column: column)
      end
    end

    def possible_moves
      @places.flatten.select { |item| item.instance_of? Move }
    end

    def perform_move(player, move)
      modified_places = @places.map { |row| row.dup }
      modified_places[move.row][move.column] = player.to_sym
      Board.new(modified_places)
    end

    def marked?(row, column)
      @places[row][column].instance_of? Symbol
    end

    def is_finished?
      possible_moves.empty?
    end

    def has_draw?
      !has_winner? && is_finished?
    end

    def has_winner?
      (rows + columns + diagonals).any? { |line| winner(line) }
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

    def winner(line) 
      line.uniq.size == 1 && line.first.is_a?(Symbol)
    end

    def elements
      @places.flatten
    end

    def to_s
      @places.flatten.map do |element|
        element.instance_of?(Move) ? "_" : element 
      end.join.to_s
    end

    def generate_key
      Digest::MD5.hexdigest(self.to_s).to_sym
    end
  end

  class Move
    attr_reader :row, :column

    def initialize(row:, column:)
      @row = row
      @column = column
    end
  end
end
