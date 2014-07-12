require 'tic_tac_toe/players/human_player'
require 'tic_tac_toe/players/fast_ai_player'

module TicTacToe
  module Players
    class PlayerFactory

      TYPES = {
        :human    => HumanPlayer,
        :computer => FastAiPlayer
      }

      def player(type:, name:)
        TYPES.fetch(type).new(name)
      end

      def types
        TYPES.keys
      end
    end
  end
end
