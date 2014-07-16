require 'tic_tac_toe/board'
require 'gui/cell'
require 'gui/board_view'

module TTTGui

  def new_game
    title "Tic-Tac-Toe"
    @players = [:x, :o]
    @board = TicTacToe::Board.create_empty
    @click_controller = Controller.new
    perform_random_moves(9)
    draw_cells
  end

  def draw_cells
    @pane = stack do
      app.board_view @board, @click_controller
    end
  end

  def perform_random_moves(n)
    n.times do
      move = @board.possible_moves.sample
      @board = @board.perform_move(@players.first, move)
      @players.rotate!
    end
  end

  class Controller
    def click(val)
      puts val
    end
  end
end
