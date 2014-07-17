module GUI
  class Controller
    def click(val)
      @val = val
    end

    def read
      new_val = @val
      @val = nil
      new_val
    end

    def ready?
      !@val.nil?
    end

    def write(msg)
      puts msg
    end
  end
end
