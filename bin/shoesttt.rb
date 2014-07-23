$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'gui/main_pane'
require 'gui/cell'
require 'tic_tac_toe/players/player_factory'

Shoes.app do
  factory = TicTacToe::Players::PlayerFactory.new({io: false})
  GUI::MainPane.new(app, factory.player_combinations ).draw do |players|
    puts players
  end
  GUI::Cell.new(app, :x, nil)
end
