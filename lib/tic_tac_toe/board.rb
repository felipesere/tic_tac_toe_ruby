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
      modified_places = @places.map { |row| row.dup }
      modified_places[move.row][move.column] = player.to_sym
      Board.new(modified_places)
    end

    def marked?(row, column)
      @places[row][column].instance_of? Symbol
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

    def winner(line) 
      line.uniq.size == 1 && line.first.is_a?(Symbol)
    end

    def initialize(places)
      @places = places
    end
  end
end
