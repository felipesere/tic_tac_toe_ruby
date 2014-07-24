require 'colorize'
require 'tic_tac_toe/ui/io'

module TicTacToe
  module UI
    class CliInterface
      def initialize(params)
        @colors = params[:colors] || false
        @clear = params[:clear] || false 
        @io = params[:io] || IO.new
        @factory = params[:factory] || nil
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
          @io.write "#{i} #{option_line(option)}"
        end
      end

      def option_line(option)
        option.join(" vs. ")
      end

      def get_chosen_players
        clear_screen
        options = @factory.player_combinations 
        print_options(options)
        choice = @io.read
        if is_number(choice) and range(options).include? choice.to_i
          @factory.players(options[choice.to_i])
        else
          get_chosen_players
        end
      end

      def is_number(input)
        begin
          Integer(input)
          true
        rescue ArgumentError
          false
        end
      end

      def range(options)
        (0..options.size-1).to_a
      end

      def clear_screen
        @io.write %x{clear} if @clear
      end

      def render(board)
        clear_screen
        printed_board = board.elements.map.each.with_index(1) do |cell, index|
          result = print_element(cell, index)
          result += "\n" if index % 3 == 0
          result
        end.join
        @io.write printed_board
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
        @io.write "#{value} was not a valid move. Try again."
      end

      def message_winner(player)
        @io.write "The winner is #{player}"
      end

      def message_draw
        @io.write "There was a draw"
      end
    end
  end
end
