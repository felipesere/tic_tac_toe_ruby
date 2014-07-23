$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'gui/game_pane'
require 'gui/click_controller'
require 'tic_tac_toe/players/player_factory'
require 'tic_tac_toe/board'
require 'tic_tac_toe/game'
require 'spec/gui/fakes'

Shoes.app :title  => "Tic TacToe",
          :width  => 270,
          :height => 400,
          :margin => 10 do
  click_controller = GUI::ClickController.new
  factory = TicTacToe::Players::PlayerFactory.new({io: click_controller})
  players = factory.players([:human, :random])
  game = TicTacToe::Game.new(*players)
  g = GUI::GamePane.new(app, click_controller)
  g.play_on(game)
end
