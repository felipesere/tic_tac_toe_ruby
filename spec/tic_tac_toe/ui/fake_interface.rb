module TicTacToe
  module UI
    class FakeInterface
      def chooses(*value)
        @value = value
      end

      def read_user_input
        if @value.empty?
          raise "Read more than expected"
        end
        "#{@value.shift}" 
      end

      def input_error(value)
      end

      def render(board)
      end

      def message_winner(player)
        raise "Unexpected winner #{player}" unless player == @winner
      end

      def expect_winner(player)
        @winner = player
      end

      def message_draw
        raise "unexpected draw!" unless @draw
      end

      def expect_draw
        @draw = true
      end

      def message(message)
      end
    end
  end
end
