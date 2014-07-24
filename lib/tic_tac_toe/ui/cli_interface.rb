require 'colorize'
require 'tic_tac_toe/ui/io'

module TicTacToe
  module UI
    class CliInterface
      def initialize(params)
        @colors = params[:colors] || false
        @clear = params[:clear] || false 
        @io = params[:io] || IO.new
        @player_combinations = params[:player_combinations] || []
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
        options = @player_combinations
        print_options(options)
        choice = @io.read
        if is_number(choice) and range(options).include? choice.to_i
          options[choice.to_i]
        else
          get_chosen_players
        end
      end

      def is_number(input)
        begin
          Integer(input)
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
        rendered_board = render_board(board)
        @io.write rendered_board
      end

      def render_board(board)
        board.elements.collect.each.with_index(1) do |cell, index|
          print_element(cell, index)
        end.each_slice(3).to_a.collect { |row| row.join}.join("\n")
      end

      def print_element(cell, index)
        content = !cell.nil? ? render_symbol(cell) : index.to_s
        "[#{content}]"
      end

      def render_symbol(cell)
        content = cell.to_s
        if @colors
          return cell == :x ? content.red : content.blue
        end
        content
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
