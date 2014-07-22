module GUI
  class FakeApp
    attr_reader :stacks
    attr_reader :buttons
    attr_reader :current_stack

    def click_on(name)
      buttons.fetch(name).call
    end
    def stack(params)
      @current_stack = FakeStack.new
      @stacks ||= []
      @stacks << current_stack
      yield
      @current_stack = stacks[-1]
    end

    def para(message)
      current_stack[:para] = 1
    end

    def button(name, &block)
      current_stack[:button] = 1
      if block_given?
        @buttons ||= {}
        buttons[name] = block
      end
    end
    
    def list_box(*args)
      box = FakeListBox.new(*args)
      current_stack[:list_box] = box
      box
    end
  end
  
  class FakeStack
    attr_reader :contents
    def initialize
      @contents = {}
    end
    def []=(key, value)
      contents[key] = value
    end
    def [](key)
      contents.fetch(key)
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
end
