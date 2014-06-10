module TicTacToe
  class Board

    def initialize(empty=true)
      @empty = empty
    end

    def empty?
      @empty
    end

    def mark(player, row: , column:)
      board = Board.new(false)
    end
  end
end
