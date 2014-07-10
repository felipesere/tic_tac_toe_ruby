require 'digest'
require 'tic_tac_toe/board_factory'

module TicTacToe
  class Board

    SIZE = 3

    def initialize(places)
      @places = places
    end

    def self.create(board)
      Board.new(board)
    end

    def possible_moves
      elements.each_with_index.map do |element, index| 
        if element.nil?
          index
        end
      end.compact
    end

    def move_table
      Hash.new.tap do |hash|
        elements.each.with_index(1) do |cell, index|
          if cell.nil?
            hash[index] = index - 1
          end
        end
      end
    end

    def perform_move(player, move)
      raise "Illegal move #{move}" unless possible_moves.include? move
      new_board = duplicate_board.flatten 
      new_board[move] = player.to_sym
      Board.new(new_board.each_slice(SIZE).to_a)
    end

    def duplicate_board
      @places.map { |row| row.dup }
    end

    def marked?(row, column)
      !@places[row][column].nil?
    end

    def is_finished?
      possible_moves.empty?
    end

    def has_draw?
      !has_winner? && is_finished?
    end

    def has_winner?
      is_winner?(:x) || is_winner?(:o)
    end

    def is_winner?(player)
      lines.any? { |line| line == [player, player, player] }
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

    def generate_key
      Digest::MD5.hexdigest(self.to_s).to_sym
    end
  end
end
