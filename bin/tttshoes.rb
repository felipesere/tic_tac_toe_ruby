$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'gui/gui'
require 'tic_tac_toe/players/player_factory'

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
    new_game *@@players, @@io
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
    def game=(game)
      @game = game
    end

    def draw(&blk)
      @draw = blk
    end

    def play
      if @val
        @game.tick
        blk.call
      end
    end

    def click(val)
      @val = val
    end

    def read
      @val
    end
    
    def write(msg)
      puts msg
    end
  end
end

Shoes.app :title => "Tic Tac Toe", :width => 300, :height => 400, :margin => 10
