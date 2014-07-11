require 'tic_tac_toe/players/human_player'
require 'tic_tac_toe/players/ai_player'
require 'tic_tac_toe/players/fast_ai_player'

module TicTacToe
  module UI
    class Settings

      SettingLine = Struct.new(:line, :players)

      def use_interface(interface)
        @interface = interface
      end

      def options 
        [  SettingLine.new("human vs. computer",     [human(:x), computer(:o)]),
           SettingLine.new("computer vs. human",     [computer(:x), human(:o)]),
           SettingLine.new("human vs. human",        [human(:x), human(:o)]),
           SettingLine.new("computer vs. computer",  [computer(:x), computer(:o)])
        ]
      end

      def human(player)
        Players::HumanPlayer.new(player, interface: @interface)
      end

      def computer(player)
        Players::FastAiPlayer.new(player)
      end
    end
  end
end
