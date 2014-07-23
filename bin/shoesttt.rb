$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'gui/main_pane'
require 'gui/board'
require 'tic_tac_toe/players/player_factory'
require 'tic_tac_toe/board'
require 'spec/gui/fakes'

Shoes.app do
  factory = TicTacToe::Players::PlayerFactory.new({io: false})
  GUI::MainPane.new(app, factory.player_combinations ).draw do |players|
    puts players
  end
  board = TicTacToe::Board.new([[:x, :o, :x],[:x, :o, :x],[:x, :o, :x]])
  GUI::Board.new(app,board, GUI::FakeClicker.new) 
end
