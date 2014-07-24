require 'tic_tac_toe/players/human_player'
require 'tic_tac_toe/players/fast_ai_player'
require 'tic_tac_toe/players/random_player'

module TicTacToe
  module Players
    module PlayerTypes
      TYPES = {
        :human    => HumanPlayer,
        :computer => FastAiPlayer,
        :random => RandomPlayer
      }

      def self.types
        TYPES.keys
      end

      def self.player_combinations
        types.permutation(2).to_a + duplications 
      end

      def self.duplications
        types.collect { |x| [x,x] }
      end
    end
  end
end
