module GUI
  class Cell
    def initialize(app, marker, controller, move)
      if marker.nil? 
        empty_image(app, controller, move)
      else
        app.image "assets/#{marker}.jpg"
      end
    end

    def empty_image(app, controller, move)
      image = app.image "assets/none.jpg"
      image.click do
        controller.click(move)
      end
    end
  end
end
