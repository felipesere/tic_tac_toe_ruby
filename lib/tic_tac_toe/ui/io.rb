module TicTacToe
  module UI
    class IO
      def initialize(input: $stdin, output: $stdout)
        @in = input
        @out = output
      end

      def write(message)
        @out.puts message
      end

      def read
        @in.gets.chomp
      end
    end
  end
end
