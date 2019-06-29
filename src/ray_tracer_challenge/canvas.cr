module RayTracerChallenge
  class Canvas
    # note: decided to use 1 dim array instead of 2 dim.
    @canvas : Array(Color)

    def initialize(@width : Int32, @height : Int32, color = Color.new(0, 0, 0))
      if width <= 0
        raise ArgumentError.new("width must be greater than 0")
      end
      if height <= 0
        raise ArgumentError.new("height must be greater than 0")
      end
      @canvas = Array.new(width * height, color)
    end

    def width
      @width
    end

    def height
      @height
    end

    def at(x, y)
      i = y * width + x
      @canvas[i]
    end

    def each_index(&block)
      (0...height).each do |y|
        (0...width).each do |x|
          yield x, y
        end
      end
    end

    def each(&block)
      each_index do |x, y|
        yield at(x, y)
      end
    end

    def each_with_index(&block)
      each_index do |x, y|
        yield x, y, at(x, y)
      end
    end

    def write(x, y, color)
      i = y * @width + x
      @canvas[i] = color
    end
  end
end
