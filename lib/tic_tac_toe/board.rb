require 'tic_tac_toe/move'

module TicTacToe
  class Board
    @size = 3

    def self.create_empty
      Board.new(create_empty_places)
    end

    def possible_moves
      @places.flatten.select { |item| item.instance_of? Move }
    end

    def perform_move(player, move)
      modified_places = duplicate_places
      modified_places[move.row][move.column] = player
      Board.new(modified_places)
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
