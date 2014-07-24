$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'gui/game_pane'
require 'gui/end_pane'
require 'gui/main_pane'
require 'gui/click_controller'
require 'tic_tac_toe/game'
require 'tic_tac_toe/players/player_factory'
require 'tic_tac_toe/players/player_types'

class MyShoes < Shoes

  url '/'     , :main_menu
  url '/game' , :game
  url '/end'  , :end_menu

  def main_menu
    @@click_controller = GUI::ClickController.new
    factory = TicTacToe::Players::PlayerFactory.new({io: @@click_controller})
    GUI::MainPane.new(app, TicTacToe::Players::PlayerTypes.player_combinations).draw do |players|
      @@players = factory.players(players)
      visit '/game'
    end
  end

  def game
    game = TicTacToe::Game.new(*@@players)
    GUI::GamePane.new(app, @@click_controller).play_on(game) do |final_board|
      @@final_board = final_board
      visit '/end'
    end
  end

  def end_menu
    GUI::EndPane.new(app, @@final_board) do |choice|
      if choice == :replay
        visit '/game'
      else
        visit '/'
      end
    end
  end
         
end
Shoes.app :title  => "Tic TacToe",
          :width  => 270,
          :height => 350,
          :margin => 20
