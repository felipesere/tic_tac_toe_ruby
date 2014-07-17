require 'tic_tac_toe/game'

class GamePane
  def initialize(app, controller)
    @app = app
    @controller = controller
  end

  def run_game(players)
    game = TicTacToe::Game.new(*players)
    draw(game.current_board)
    core_loop = @app.animate(10) do  
      if game.is_finished?
        core_loop.stop
        yield
      else
        if game.ready?
          game.tick
        end
        redraw(game.current_board)
      end
    end
  end

  def draw(board)
    @app.stack do
      @app.title "Tic-Tac-Toe"
      @board = @app.stack do
        @app.board_view board, @controller 
      end
    end
  end

  def redraw(board)
    @board.clear do
      @app.board_view board, @controller
    end
  end
end
