module GUI
  class MainPane
    attr_reader :app
    attr_reader :player_combinations
    def initialize(app, player_combinations)
      @player_combinations = player_combinations
      @app = app
    end

    def draw(&after_finish)
      app.stack margin: 10 do
        app.para "Please select a player combination"
        place_list_box(&after_finish)
      end
    end

    def place_list_box(&after_finish)
      handle = app.list_box :items => items.keys, :choose => items.keys.first 
      app.button "Play!" do
        after_finish.call items[handle.text]
      end
    end

    def items
      player_combinations.inject({}) do |hash, combo| 
        hash[combo.join(" vs. ")] = combo
        hash
      end
    end
  end
end
