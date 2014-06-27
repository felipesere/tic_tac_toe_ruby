module TicTacToe
  module UI
    class CliInput
      def initialize(source = $stdin)
        @source = source
      end

      def get_input
        begin
          Integer(@source.read.chomp)
        rescue
          retry
        end
      end
    end
  end
end
