require 'colorize'

module TicTacToe
  module UI
    class CliInterface
      def render(board)
        print %x{clear}
        printed_board = board.elements.collect.each.with_index(1) do |cell, index|
          result = convert_element(cell, index)
          result += "\n" if index % 3 == 0
          result
        end.join
        puts printed_board
      end

      def convert_element(cell, index)
        if cell.instance_of? Symbol
          color_cell(cell)
        else
          "[#{index}]"
        end
      end

      def color_cell(cell)
        result = "[#{cell}]"
        cell == :x ? result.red : result.blue
      end

      def get_move(board)
        user_choice = Integer($stdin.gets.chomp)
        move_table = build_move_table(board)
        move_table[user_choice]
      end

      def build_move_table(board)
        result = {}
        board.elements.each.with_index(1) do |cell, index|
          if cell.instance_of? Move
            result[index] = cell
          end
        end
        result
      end
    end
  end
end
