module TicTacToe
  module UI
    class IO
      def initialize(input: $stdin, output: $stdout)
        @in = input
        @out = output
      end

      def message(message)
        @out.puts message
      end

      def read
        @in.gets.chomp
      end
    end
  end
end
