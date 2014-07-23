module GUI
  class FakeApp
    attr_reader :images 
    attr_reader :buttons
    attr_reader :stored_list_boxes
    def initialize
      reset
    end
    def reset
      @buttons = {}
      @images = []
      @stored_list_boxes = []
      @animation = nil
    end

    def click_on(name)
      buttons.fetch(name).call
    end

    def stack(params = {})
      stack = FakeStack.new
      yield if block_given?
      stack
    end

    def flow(params = {})
      yield if block_given?
    end

    def para(message)
    end

    def image(path)
      image = FakeImage.new(path)
      @images ||= [] 
      @images << image
      image
    end

    def images_like(regex)
      images.find_all { |image| image.path.match(regex) }
    end

    def button(name, &block)
      if block_given?
        @buttons ||= {}
        buttons[name] = block
      end
    end

    def list_boxes
      stored_list_boxes
    end

    def list_box(*args)
      box = FakeListBox.new(*args)
      stored_list_boxes ||= []
      @stored_list_boxes << box
      box
    end

    def animate(iter, &block)
      @animation = FakeAnimation.new(&block) 
      @animation
    end

    def animation
      @animation
    end
  end

  class FakeStack
   def clear
     yield
   end
  end
  class FakeListBox
    attr_reader :items
    def initialize(args)
      @items = args.fetch(:items)
      args.fetch(:choose)
    end
    def text
      items.first
    end
  end

  class FakeImage
    attr_reader :path
    def initialize(path)
      @path = path
    end

    def click(&block)
      @block = block
    end
    def click!
      @block.call if @block
    end
  end

  class FakeClicker
    def initialize
      @clicked = false
    end
    def click(data = {})
      @clicked = true
      @data = data
    end

    def click_data
      raise NotYetClicked < StandardError unless clicked?
      @data
    end
    def clicked?
      @clicked
    end
  end

  class FakeAnimation
    attr_reader :block
    def initialize(&block)
      @block = block
    end
    def run!
      block.call unless stopped?
    end
    
    def stop
      @stop = true
    end

    def stopped?
      @stop
    end
  end
end
