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

  def draw_main_menu(factory)
    options = convert_for_ui(factory.player_combinations) 

    stack :margin =>  10 do
      para "Choose a player combinations"

      @handle = list_box  :items => options.keys, :choose => options.keys.first

      button "Play!" do
        @@players = factory.players(options[@handle.text])
        yield
      end
    end
  end

  def convert_for_ui(player_combinations)
    result = {}
    player_combinations.each do |combination|
      lines = "#{combination[0]} vs #{combination[1]}"
      result[lines] = combination
    end
    result
  end

  def run_game
    game = TicTacToe::Game.new(*@@players)
    draw(game.current_board)
    core_loop = animate(10) do  
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

  def redraw(board)
    @@board.clear do
      app.board_view board, @@controller
    end
  end
end
