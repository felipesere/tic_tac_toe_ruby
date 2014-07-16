class BoardView < Shoes::Widget
  def initialize(board, controller)
    board.rows.each do |row|
      flow width: 270 do
        row.each do |marker|
          stack width: 1.0/row.size do
            app.cell marker, controller
          end
        end
      end
    end
  end
end
