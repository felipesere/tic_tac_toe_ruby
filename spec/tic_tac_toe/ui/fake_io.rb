module TicTacToe
  module UI
    class FakeIO
      def chooses(*chooses)
        @input = chooses
      end
      
      def rewind
        @messages = []
        not_ready!
      end

      def write(message)
        @messages ||= []
        @messages << message
      end

      def read
        @input.shift.to_s
      end

      def string
        @messages.join
      end

      def ready!
        @ready = true
      end

      def not_ready!
        @ready = false
      end

      def ready?
        @ready
      end
    end
  end
end
