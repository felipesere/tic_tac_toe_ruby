module GUI
  class FakeApp
    attr_reader :images 
    attr_reader :buttons
    attr_reader :stored_list_boxes
    def reset
      @buttons = {}
      @images = []
      @stored_list_boxes = []
    end

    def click_on(name)
      buttons.fetch(name).call
    end

    def stack(params)
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
end
