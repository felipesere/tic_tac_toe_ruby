module TicTacToe
  module UI
    class Cell
      def initialize(val)
        @val = val
      end

      def paint
        "[#{@val.to_s.rjust(1)}]"
      end
    end
  end
end
