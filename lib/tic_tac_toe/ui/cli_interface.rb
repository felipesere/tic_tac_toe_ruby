module TicTacToe
  module UI
    class CliInterface
      def render(board)
        board.elements.collect.each.with_index(1) do |cell, index|
          result = convert_element(cell, index)
          result += "\n" if index % 3 == 0
          result
        end.join
      end

      def convert_element(cell, index)
        if cell.instance_of? Symbol
          "[#{cell}]"
        else
          "[#{index}]"
        end
      end
      def get_move(board, user_input)
        user_choice = Integer(user_input)
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
