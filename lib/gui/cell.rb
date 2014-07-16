class Cell < Shoes::Widget
  def initialize(marker, controller)
    mark = marker.nil? ? :none : marker

    element =  image "assets/#{mark}.jpg"

    element.click do
      element.path = "assets/none.jpg"
      controller.click("Hello!")
    end
  end
end
