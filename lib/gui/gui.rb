require 'gui/cell'
require 'gui/board_view'
require 'tic_tac_toe/game'

module TTTGui

  def new_game(a,b, click_controller)
    @@click_controller = click_controller
    game = TicTacToe::Game.new(a,b)
    @@click_controller.game = game
    stack do
      title "Tic-Tac-Toe"
      stack do
        @@board = app.board_view game.current_board, click_controller
      end
    end
    @@click_controller.draw do
      redraw
    end
    @@click_controller.play
  end


  def redraw
    @@board.clear do
      app.board_view game.current_board @@click_controller
    end
  end
end
