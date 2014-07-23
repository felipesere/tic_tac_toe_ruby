module GUI
  class GamePane
    attr_reader :app
    def initialize(app)
      @app = app
      @main = app.stack 
    end
  
    def play_on(game, &finished_block)
      draw(game.current_board)
      core_loop = app.animate(10) do
        animate(game, core_loop, &finished_block)
      end
    end

    def animate(game, core_loop, &finished_block)
      if game.is_finished?
        finish(core_loop, &finished_block)
      else
        proceed(game)
      end
    end

    def finish(core_loop, &finished_block)
      core_loop.stop
      finished_block.call if finished_block
    end

    def proceed(game)
      if game.ready?
        game.tick
      end
      draw(game.current_board)
    end

    def draw(board)
      @main.clear do
        Board.new(app, board, nil)
      end
    end
  end
end