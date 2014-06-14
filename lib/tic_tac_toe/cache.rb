module TicTacToe
  class Cache
    def initialize
      @elements = {}
      @requests=0
      @hits=0
    end

    def read(key)
      @requests = @requests + 1
      value = @elements[key]
      if value
        @hits = @hits + 1
      end
      value
    end

    def write(key, value)
      @elements[key] = value
    end

    def hit_percentage
      @hits.to_f/@requests.to_f
    end

    def requests
      @requests
    end
  end
end
