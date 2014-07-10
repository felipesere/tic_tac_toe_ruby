require 'colorize'

module TicTacToe
  module UI
    class CliInterface
      def initialize(input: $stdin, output: $stdout, colors: false, clear: false)
        @input = input
        @output = output
        @colors = colors
        @clear = clear
      end

      def play_on(game)
        render(game.current_board)
        until game.is_finished? do 
          game.tick
          render(game.current_board)
        end
        result(game.current_board)
      end

      def render(board)
        message %x{clear} if @clear
        printed_board = board.elements.collect.each.with_index(1) do |cell, index|
          result = print_element(cell, index)
          result += "\n" if index % 3 == 0
          result
        end.join
        message printed_board
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

      def result(board)
        if board.has_winner?
          message_winner(:x)
        else
          message_draw
        end
      end
      def input_error(value)
        message "#{value} was not a valid move. Try again."
      end

      def message_winner(player)
        message "The winner is #{player}"
      end

      def message_draw
        message "There was a draw"
      end

      def message(message)
        @output.puts message
      end

      def read_user_input
        @input.gets.chomp
      end
    end
  end
end
