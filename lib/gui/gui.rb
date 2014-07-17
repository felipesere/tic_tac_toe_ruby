require 'gui/cell'
require 'gui/board_view'
require 'tic_tac_toe/game'

module TTTGui

  def set_controller(controller)
    @@controller = controller
  end

  def draw(board)
    stack do
      title "Tic-Tac-Toe"
      @@board = stack do
        app.board_view board, @@controller 
      end
    end
  end

  def redraw(board)
    @@board.clear do
      app.board_view board, @@controller
    end
  end
end
