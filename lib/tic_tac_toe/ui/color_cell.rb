require 'tic_tac_toe/ui/cell'
require 'colorize'

module TicTacToe
  module UI
    class ColorCell
      attr_reader :val
      def initialize(val)
        @val = val
        @cell = Cell.new(val)
      end

      def paint
        if [:x,:o].include? @val
          color_paint(@cell.paint)
        else
          @cell.paint
        end
      end

      def color_paint(content)
        if val == :x
          content.red
        else
          content.blue
        end
      end
    end
  end
end
