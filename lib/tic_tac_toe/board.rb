require 'tic_tac_toe/move'

module TicTacToe
  class Board

    def self.empty
      places = create_empty_places()
      Board.new(places)
    end

    def self.create_empty_places
      places = []
      (0..2).each do |row| 
        places[row] = [:none, :none, :none]
      end
      places
    end

    def initialize(marked_places)
      @places = marked_places
    end

    def marked?(row, column)
      @places[row][column] != :none
    end

    def possible_moves
      possible_moves = []

      @places.each_index do |row|
        @places[row].each_index do |column|
          if @places[row][column] == :none
            possible_moves << Move.new(row, column)
          end
        end
      end

      possible_moves
    end

    def mark(player, row: , column:)    
      new_places_state = duplicate_places()
      new_places_state[row][column] = player
      board = Board.new(new_places_state)
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
