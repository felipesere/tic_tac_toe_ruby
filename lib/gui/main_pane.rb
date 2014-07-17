class MainPane
  def initialize(app, factory)
    @app = app
    @factory = factory
  end

  def draw(&finish)
    options = convert_for_ui(@factory.player_combinations) 

    @app.stack :margin =>  10 do
      @app.para "Choose a player combinations"

      @handle = @app.list_box  :items => options.keys, :choose => options.keys.first

      @app.button "Play!" do
       players = @factory.players(options[@handle.text])
       finish.call(players)
      end
    end
  end

  def convert_for_ui(player_combinations)
    result = {}
    player_combinations.each do |combination|
      lines = "#{combination[0]} vs #{combination[1]}"
      result[lines] = combination
    end
    result
  end
end
