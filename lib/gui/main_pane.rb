module GUI
  class MainPane
    attr_reader :app
    def initialize(app, player_combinations)
      @player_combinations = player_combinations
      @app = app
    end

    def draw(&after_finish)
      items = convert_players_for_ui(@player_combinations)
      app.stack margin: 10 do
        app.para "Hello"
        handle = app.list_box :items => items.keys, :choose => "Random text" 
        app.button "Play!" do
          after_finish.call items[handle.text]
        end
      end
    end

    def convert_players_for_ui(combinations)
      result = {}
      combinations.each do |combo| 
        line = combo.join(" vs. ")
        result[line] = combo
      end
      result
    end
  end
end
