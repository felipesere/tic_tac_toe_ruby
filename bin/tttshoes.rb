$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'gui/gui'
require 'gui/controller'
require 'tic_tac_toe/players/player_factory'
require 'tic_tac_toe/board'

class MyApp < Shoes
  include TTTGui

  url '/',      :main_menu
  url '/game',  :game
  url '/end',   :retry

  @@io ||= GUI::Controller.new
  @@factory  ||= TicTacToe::Players::PlayerFactory.new(io: @@io)

  def main_menu
    set_controller(@@io)
    draw_main_menu @@factory  do
      visit '/game'
    end
  end

  def game
    run_game do
      visit '/end'
    end
  end


  def retry
    visit '/'
  end
end

Shoes.app :title => "Tic Tac Toe", :width => 300, :height => 400, :margin => 10
