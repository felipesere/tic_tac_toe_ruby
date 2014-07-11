require 'colorize'

module TicTacToe
  module UI
    class CliInterface
      def initialize(input: $stdin, output: $stdout, colors: false, clear: false, settings: Settings.new )
        @input = input
        @output = output
        @colors = colors
        @clear = clear
        @settings = settings
        @settings.use_interface(self)
      end

      def get_selected_players
        @settings.options.each_with_index do |option, index|
          message "#{index} #{option.line}"
        end
        choice = read_user_input.to_i
        @settings.options[choice]
      end
      
      def play_on(game)
        until game.is_finished? do 
          render(game.current_board)
          game.tick
        end
        result(game.current_board)
      end

      def render(board)
        message %x{clear} if @clear
        printed_board = board.elements.map.each.with_index(1) do |cell, index|
          result = print_element(cell, index)
          result += "\n" if index % 3 == 0
          result
        end.join
        message printed_board
      end

      def print_element(cell, index)
        if cell.nil?
          "[#{index}]"
        else
          color_cell(cell)
        end
      end

      def color_cell(cell)
        result = "[#{cell}]"
        if @colors
          result = cell == :x ? result.red : result.blue
        end
        result
      end

      def result(board)
        render(board)
        if board.has_winner?
          message_winner(board.winner)
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
