require 'rspec'
require 'simplecov'

SimpleCov.start do
  add_filter 'spec/'
end

require 'tic_tac_toe/board'
require 'tic_tac_toe/move'
include TicTacToe
