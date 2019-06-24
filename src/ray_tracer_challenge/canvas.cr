class Canvas
  @canvas : Array(Color) # note: decided to use 1 dim array instead of 2 dim.

  def initialize(@width : Int32, @height : Int32)
    @canvas = Array.new(width * height, Tuple.color(0, 0, 0))
  end

  def width
    @width
  end

  def height
    @height
  end

  def at(x, y)
    i = y * @width + x
    @canvas[i]
  end

  def each(&block)
    (0...@height).each do |y|
      (0...@width).each do |x|
        yield x, y, at(x, y)
      end
    end
  end
end
