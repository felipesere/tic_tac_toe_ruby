require 'gui/board'
module GUI
  class GamePane
    attr_reader :app
    attr_reader :click_controller

    def initialize(app, click_controller)
      @app = app
      @click_controller = click_controller
      @main = app.stack 
    end
  
    def play_on(game, &finished_block)
      draw(game.current_board)
      core_loop = app.animate(20) do
        animate(game, core_loop, &finished_block)
      end
    end

    def animate(game, core_loop, &finished_block)
      if game.is_finished?
        finish(core_loop, game, &finished_block)
      else
        proceed(game)
      end
    end

    def finish(core_loop, game, &finished_block)
      core_loop.stop
      finished_block.call(game.current_board) if finished_block
    end

    def proceed(game)
      if game.ready?
        game.tick
      end
      draw(game.current_board)
    end

    def draw(board)
      @main.clear do
        Board.new(app, board, click_controller)
      end
    end
  end
end
