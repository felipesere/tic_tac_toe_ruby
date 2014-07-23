require 'gui/cell'

module GUI
  class Board
    attr_reader :app
    attr_reader :click_controller
    attr_reader :move

    def initialize(app, game_board, click_controller)
      @app = app
      @click_controller = click_controller
      @move = 1

      build_board(game_board)
    end

    def build_board(game_board)
      app.stack do 
        game_board.rows.each do |row|
          app.flow width: 270 do
            build_row(row)
          end
        end
      end
    end

    def build_row(row)
      row.each do |marker|
        app.stack width: 0.3 do
          Cell.new(app, marker, click_controller,next_move)
        end
      end
    end
    
    def next_move
      i = move 
      @move += 1
      i
    end
  end
end
