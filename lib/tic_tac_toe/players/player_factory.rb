require 'tic_tac_toe/players/human_player'
require 'tic_tac_toe/players/fast_ai_player'

module TicTacToe
  module Players
    class PlayerFactory

      def initialize(params)
        @params = params
      end

      TYPES = {
        :human    => HumanPlayer,
        :computer => FastAiPlayer
      }

      def players(types)
        [
          player(type: types[0], name: :x),
          player(type: types[1], name: :o)
        ]
      end

      def player(params)
        type = params.fetch(:type)
        name = params.fetch(:name)
        TYPES.fetch(type).new(name, @params)
      end

      def types
        TYPES.keys
      end
      
      def player_combinations
        types.permutation(2).to_a + duplications 
      end

      def duplications
        types.collect { |x| [x,x] }
      end
    end
  end
end
