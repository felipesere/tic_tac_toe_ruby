$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'gui/gui'
require 'gui/board_view'
require 'gui/controller'
require 'tic_tac_toe/players/player_factory'
require 'tic_tac_toe/board'
require 'gui/main_pane'
require 'gui/game_pane'

class MyApp < Shoes
  url '/',      :main_menu
  url '/game',  :game
  url '/end',   :retry

  @@io = GUI::Controller.new
  @@factory  = TicTacToe::Players::PlayerFactory.new(io: @@io)

  def main_menu
    MainPane.new(app, @@factory).draw do |chosen_players|
      @@players = chosen_players
      visit '/game'
    end
  end

  def game
    GamePane.new(app, @@io).run_game(@@players) do
      visit '/end'
    end
  end

  def retry
    visit '/'
  end
end

Shoes.app :title => "Tic Tac Toe", :width => 300, :height => 400, :margin => 10
