module GUI
  class EndPane
    attr_reader :app
    attr_reader :final_board
    def initialize(app, final_board = nil, &finish_block)
      @app = app
      @final_board = final_board
      app.stack :margin =>  10 do
        place_message
        place_buttons(&finish_block)
      end
    end

    def place_message
      app.para message, :size => 20
    end

    def message
      if final_board.has_winner?
        message = "#{final_board.winner} won"
      else
        message = "there was a draw"
      end
    end

    def place_buttons(&finish_block)
      app.flow do
        { 
          'Play again' => :replay,
          'Main menu' => :menu 
        }.each do |button, value|
          app.button button do
            finish_block.call value
          end
        end
      end
    end
  end
end
