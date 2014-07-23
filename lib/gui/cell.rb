module GUI
  class Cell
    def initialize(app, marker, controller)
      if marker.nil? 
        image = app.image "assets/none.jpg"
        image.click do
          controller.click
        end
      else
        app.image "assets/#{marker}.jpg"
      end
    end
  end
end
