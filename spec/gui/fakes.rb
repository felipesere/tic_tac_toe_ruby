module GUI
  class FakeApp
    attr_reader :buttons
    attr_reader :stored_list_boxes
    def reset
      @buttons = {}
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
  
  class FakeStack
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
end
