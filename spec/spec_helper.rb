require 'rspec'
require 'simplecov'

SimpleCov.start do
  add_filter "spec/"
end

require 'tic_tac_toe/board'
include TicTacToe
