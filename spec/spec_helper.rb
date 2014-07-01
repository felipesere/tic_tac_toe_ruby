require 'rspec'

require 'simplecov'

SimpleCov.start do
  add_filter "spec"
end


require 'tic_tac_toe/board'
require 'tic_tac_toe/players/ai_player'
require 'tic_tac_toe/players/human_player'
require 'tic_tac_toe/ui/cli_interface'
require 'tic_tac_toe/ui/fake_interface'
require 'tic_tac_toe/game'

include TicTacToe
include TicTacToe::Players
include TicTacToe::UI

