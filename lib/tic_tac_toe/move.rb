module TicTacToe
  class Move
    attr_reader :row
    attr_reader :column

    def initialize(row:, column:)
      @row = row
      @column = column
    end
   
    

    def to_s
      " "
    end
  end
end
