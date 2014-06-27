module TicTacToe
  class CliDisplay
    def render(board)
      result = ""
      index = 1
      board.rows.each_with_index do |row| 
        row.each_with_index do |cell| 
          if cell.instance_of? Symbol
            result += "[#{cell}]"
          else
            result += "[#{index}]"
            index += 1 
          end
        end
        result += "\n"
      end
      result
    end
  end
end
