module TicTacToe
  module UI
    class IO
      def initialize(params)
        @in = params[:input] || $stdin
        @out = params[:output] || $stdout
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
