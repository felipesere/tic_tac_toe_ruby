require 'gui/cell'

module GUI
  class Board
    attr_reader :app
    attr_reader :click_controller
    attr_reader :index

    def initialize(app, game_board, click_controller)
      @app = app
      @click_controller = click_controller
      @index = 1
      build_board(game_board)
    end

    def build_board(game_board)
      game_board.rows.each do |row|
        build_row(row)
      end
    end

    def build_row(row)
      row.each do |marker|
        Cell.new(app, marker, click_controller,index)
        @index += 1
      end
    end
  end
end
