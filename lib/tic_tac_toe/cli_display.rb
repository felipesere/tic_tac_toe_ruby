module TicTacToe
  class CliDisplay
    def render(board)
      result = ""
      index = 1
      board.rows.each do |row| 
        row.each do |cell| 
          if cell.instance_of? Symbol
            result += "[#{cell}]"
          else
            result += "[#{index}]"
          end
          index += 1 
        end
        result += "\n"
      end
      result
    end
  end
end
