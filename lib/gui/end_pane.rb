module GUI
  class EndPane
    attr_reader :app
    attr_reader :final_board
    attr_reader :finish_block

    BUTTONS = { 
      'Play again' => :replay,
      'Main menu' => :menu }

    def initialize(app, final_board = nil, &finish_block)
      @app = app
      @final_board = final_board
      @finish_block = finish_block
      draw
    end

    def draw
      app.stack :margin =>  10 do
        draw_message
        draw_buttons
      end
    end

    def draw_message
      app.para message, :size => 20
    end

    def message
      if final_board.has_winner?
        message = "#{final_board.winner} won"
      else
        message = "there was a draw"
      end
    end

    def draw_buttons
      app.flow do
        add_buttons
      end
    end

    def add_buttons
      BUTTONS.each do |button, value|
        app.button button do
          finish_block.call value
        end
      end
    end
  end
end
