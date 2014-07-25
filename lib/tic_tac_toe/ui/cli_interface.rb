require 'colorize'
require 'tic_tac_toe/ui/io'
require 'tic_tac_toe/ui/cell'

module TicTacToe
  module UI
    class CliInterface
      attr_reader :player_combinations
      def initialize(params)
        @clear = params[:clear] || false 
        @io = params[:io] || IO.new
        @player_combinations = params[:player_combinations] || []
        @painter = params[:painter] || Cell
      end

      def play_on(game)
        until game.is_finished? do 
          render(game.current_board)
          game.tick
        end
        result(game.current_board)
      end

      def print_options
        player_combinations.each_with_index do |option, i|
          @io.write "#{i} #{option_line(option)}"
        end
      end

      def option_line(option)
        option.join(" vs. ")
      end

      def get_chosen_players
        clear_screen
        print_options
        choice = @io.read
        select(choice)
      end
      
      def select(choice)
        if is_number(choice) and range.include? choice.to_i
          player_combinations[choice.to_i]
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

      def range
        (0..player_combinations.size-1).to_a
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
          render_element(cell, index)
        end.each_slice(3).to_a.collect { |row| row.join}.join("\n")
      end

      def render_element(cell, index)
        painter = cell.nil? ? @painter.new(index) : @painter.new(cell)
        painter.paint
      end

      def result(board)
        render(board)
        render_message(board)
      end

      def render_message(board)
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
