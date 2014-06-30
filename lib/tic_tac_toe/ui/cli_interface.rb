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

      def get_move(board)
        move_table = build_move_table(board)
        move = nil
        while move.nil? do
          user_choice = read_user_input
          move = move_table[user_choice]
          if move.nil?
            input_error(user_choice)
          end
        end
        move
      end

      def input_error(value)
        @output.puts "#{value} was not a valid move. Try again."
      end

      def read_user_input
        begin
          value = @input.gets.chomp
          Integer(value)
        rescue ArgumentError
          input_error(value)
          retry
        end
      end

      def build_move_table(board)
        result = {}
        board.elements.each.with_index(1) do |cell, index|
          if cell.instance_of? Move
            result[index] = cell
          end
        end
        result
      end
    end
  end
end
