require 'rspec'
require 'simplecov'

SimpleCov.start do
  add_filter 'spec/'
end

require 'tic_tac_toe/board'
require 'tic_tac_toe/move'
require 'tic_tac_toe/player'
require 'tic_tac_toe/cache'

include TicTacToe
