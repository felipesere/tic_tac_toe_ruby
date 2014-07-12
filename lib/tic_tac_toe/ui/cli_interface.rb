require 'colorize'
require 'tic_tac_toe/ui/io'
require 'tic_tac_toe/players/player_factory'

module TicTacToe
  module UI
    class CliInterface
      def initialize(io: IO.new, colors: false, clear: false, factory: nil)
        @colors = colors
        @clear = clear
        @io = io
        @factory = factory
      end

      def play_on(game)
        until game.is_finished? do 
          render(game.current_board)
          game.tick
        end
        result(game.current_board)
      end

      def print_options(options)
        options.each_with_index do |option, i|
          @io.message "#{i} #{option_line(option)}"
        end
      end

      def option_line(option)
        option.join(" vs. ")
      end

      def get_chosen_players
        options = @factory.combinations 
        print_options(options)
        choice = @io.read.to_i
        @factory.players(options[choice])
      end

      def render(board)
        @io.message %x{clear} if @clear
        printed_board = board.elements.map.each.with_index(1) do |cell, index|
          result = print_element(cell, index)
          result += "\n" if index % 3 == 0
          result
        end.join
        @io.message printed_board
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
        @io.message "#{value} was not a valid move. Try again."
      end

      def message_winner(player)
        @io.message "The winner is #{player}"
      end

      def message_draw
        @io.message "There was a draw"
      end
    end
  end
end
