module GUI
  class Cell
    def initialize(app, marker, controller, move)
      if marker.nil? 
        image = app.image "assets/none.jpg"
        image.click do
          controller.click(move)
        end
      else
        app.image "assets/#{marker}.jpg"
      end
    end
  end
end
