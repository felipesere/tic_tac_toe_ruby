module GUI
  class ClickController
    def click(data)
      @data = data
    end

    def read
      result = @data
      @data = nil
      result
    end

    def ready?
      !@data.nil?
    end
  end
end
