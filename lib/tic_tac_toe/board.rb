require 'tic_tac_toe/move'

module TicTacToe
  class Board
    @size = 3

    def self.create_empty
      Board.create([[nil, nil, nil],[nil, nil, nil],[nil, nil, nil]])
    end

    def self.create(board)
      board.each_index do |row|
        board[row].each_index do |column|
          if board[row][column] == nil 
            board[row][column] = Move.new(row: row, column: column)
          end
        end
      end
      Board.new(board)
    end

    def possible_moves
      @places.flatten.select { |item| item.instance_of? Move }
    end

    def perform_move(player, move)
      modified_places = duplicate_places
      modified_places[move.row][move.column] = player.to_sym
      Board.new(modified_places)
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
      [@places.flatten.values_at(0,4,8), @places.flatten.values_at(2,4,6)]
    end

    def winner(row) 
      row.uniq.size == 1 && row[0].is_a?(Symbol)
    end

    private

    def self.create_empty_places
      places = []
      (0...@size).each do |row|
        places[row] = []
        (0...@size).each do |column|
          places[row] << Move.new(row: row, column: column)
        end
      end
      places
    end

    def initialize(places)
      @places = places
    end

    def duplicate_places
      new_places = []
      @places.each do |row|
        new_places << row.dup
      end
      new_places
    end
  end
end
