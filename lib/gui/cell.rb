class Cell < Shoes::Widget
  def initialize(marker, index , controller)
    
    if marker.nil?
      element =  image "assets/none.jpg"
      element.click do
        controller.click(index)
      end
    else
      image "assets/#{marker}.jpg"
    end
  end
end
