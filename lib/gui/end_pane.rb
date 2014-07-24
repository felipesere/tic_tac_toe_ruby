module GUI
  class EndPane
    def initialize(app, &blk)
      { 
        'Play again' => :replay,
        'Main menu' => :menu 
      }.each do |button, value|
        app.button button do
          blk.call value
        end
      end
    end
  end
end
