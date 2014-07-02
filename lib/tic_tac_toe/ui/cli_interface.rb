require 'colorize'

module TicTacToe
  module UI
    class CliInterface
      def initialize(input = $stdin, output = $stdout, colors=false, clear=false)
        @input = input
        @output = output
        @colors = colors
        @clear = clear
      end

      def render(board)
        @output.puts %x{clear} if @clear
        printed_board = board.elements.collect.each.with_index(1) do |cell, index|
          result = print_element(cell, index)
          result += "\n" if index % 3 == 0
          result
        end.join
        @output.puts printed_board
      end

      def print_element(cell, index)
        if cell.instance_of? Symbol
          color_cell(cell)
        else
          "[#{index}]"
        end
      end

      def color_cell(cell)
        result = "[#{cell}]"
        if @colors
          result = cell.to_sym == :x ? result.red : result.blue
        end
        result
      end

      def input_error(value)
       @output.puts "#{value} was not a valid move. Try again."
      end

      def read_user_input
        @input.gets.chomp
      end

      def message_winner(player)
        @output.puts "The winner is #{player}"
      end

      def message_draw
        @output.puts "There was a draw"
      end

      def message(message)
        @output.puts message
      end
    end
  end
end
