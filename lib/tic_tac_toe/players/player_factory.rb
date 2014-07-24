require 'tic_tac_toe/players/player_types'

module TicTacToe
  module Players
    class PlayerFactory

      def initialize(params)
        @params = params
      end

      def players(types)
        [ player(type: types[0], name: :x),  player(type: types[1], name: :o) ]
      end

      def player(params)
        type = params.fetch(:type)
        name = params.fetch(:name)
        PlayerTypes::TYPES.fetch(type).new(name, @params)
      end
    end
  end
end
