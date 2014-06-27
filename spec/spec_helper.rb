require 'rspec'

require 'tic_tac_toe/board'
require 'tic_tac_toe/players/ai_player'
require 'tic_tac_toe/players/random_player'
require 'tic_tac_toe/ui/cli_display'
require 'tic_tac_toe/ui/cli_input'

include TicTacToe
include TicTacToe::Players
include TicTacToe::UI
