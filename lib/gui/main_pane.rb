module GUI
  class MainPane
    attr_reader :app
    def initialize(app, factory)
      @app = app
    end

    def draw(&after_finish)
      app.stack margin: 10 do
        app.para "Hello"
        app.list_box :items => [], :choose => "Random text" 
        app.button "Play!" do
          after_finish.call [:a, :b]
        end
      end
    end

    def convert_players_for_ui(combinations)
      result = {}
      combinations.each do |combo| 
        result[combo] = combo.join(" vs. ") 
      end
      result
    end
  end
end
