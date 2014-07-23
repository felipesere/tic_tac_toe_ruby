$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'gui/game_pane'
require 'gui/board'
require 'tic_tac_toe/players/player_factory'
require 'tic_tac_toe/board'
require 'tic_tac_toe/game'
require 'spec/gui/fakes'

Shoes.app do
  factory = TicTacToe::Players::PlayerFactory.new({io: false})
  players = factory.players([:random, :random])
  game = TicTacToe::Game.new(*players)
  g = GUI::GamePane.new(app)
  g.play_on(game)
end
