$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'gui/gui'
require 'tic_tac_toe/players/player_factory'
require 'tic_tac_toe/board'

class MyApp < Shoes
  include TTTGui

  url '/',      :main_menu
  url '/game',  :game
  url '/end',   :retry

  def main_menu
    @@io ||= Controller.new
    @factory  ||= TicTacToe::Players::PlayerFactory.new(io: @@io)
    options = convert_for_ui(@factory.player_combinations) 

    stack :margin =>  10 do
      para "Choose a player combinations"

      @handle = list_box  :items => options.keys, 
        :choose => options.keys.first

      button "Play!" do
        @@players = @factory.players(options[@handle.text])
        visit '/game'
      end
    end
  end

  def game
    set_controller(@@io)
    game = TicTacToe::Game.new(*@@players)
    draw(game.current_board)
    core_loop = animate(10) do  
      if game.is_finished?
        core_loop.stop
        visit '/end'
      else
        if game.ready?
          game.tick
        end
        redraw(game.current_board)
      end
    end
  end

  def retry
    visit '/'
  end

  def convert_for_ui(player_combinations)
    result = {}
    player_combinations.each do |combination|
      lines = "#{combination[0]} vs #{combination[1]}"
      result[lines] = combination
    end
    result
  end

  class Controller
    def click(val)
      @val = val
    end

    def read
      new_val = @val
      @val = nil
      new_val
    end

    def write(msg)
      puts msg
    end
  end
end

Shoes.app :title => "Tic Tac Toe", :width => 300, :height => 400, :margin => 10
