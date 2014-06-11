module TicTacToe
  class Move
    attr_reader :row
    attr_reader :column

    def initialize(row:, column:)
      @row = row
      @column = column
    end
  end
end
