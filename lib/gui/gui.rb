require 'gui/cell'
require 'gui/board_view'
require 'tic_tac_toe/game'

module TTTGui

  def draw(board)
    stack do
      title "Tic-Tac-Toe"
      @@board = stack do
        app.board_view board, false 
      end
    end
  end

  def redraw(board)
    @@board.clear do
      app.board_view board, false
    end
  end
end
