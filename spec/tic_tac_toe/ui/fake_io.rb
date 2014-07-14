module TicTacToe
  module UI
    class FakeIO
      def chooses(*chooses)
        @input = chooses
      end
      
      def rewind
        @messages = []
      end

      def write(message)
        @messages ||= []
        @messages << message
      end

      def read
        @input.shift
      end

      def string
        @messages.join
      end
    end
  end
end
