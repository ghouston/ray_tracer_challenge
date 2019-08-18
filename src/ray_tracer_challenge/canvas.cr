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
      i = index_for(x, y)
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

    # yields |x, y, value| however, iterates the y from max down to 0
    #
    # similar to each_with_index, however the y axis order is reversed.
    def flipped_each_with_index(&block)
      flipped_each_index do |x, y|
        yield x, y, at(x, y)
      end
    end

    def flipped_each_index(&block)
      (height - 1).downto(0).each do |y|
        (0...width).each do |x|
          yield x, y
        end
      end
    end

    def write(x, y, color)
      i = index_for(x, y)
      @canvas[i] = color
    end

    private def index_for(x, y)
      y.to_i * @width + x.to_i
    end
  end
end
