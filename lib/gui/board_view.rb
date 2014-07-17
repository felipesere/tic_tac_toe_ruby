class BoardView < Shoes::Widget
  def initialize(board, controller)
    board.rows.each_with_index do |row, row_index|
      flow width: 270 do
        row.each_with_index do |marker, column_index|
          stack width: 0.3 do
            index = 1 + (row_index * 3) + column_index 
            app.cell marker, index, controller
          end
        end
      end
    end
  end
end
