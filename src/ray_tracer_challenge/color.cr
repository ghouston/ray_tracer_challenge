struct Tuple
  def to_color
    Color.new(self[0], self[1], self[2])
  end
end

module RayTracerChallenge
  struct Color
    getter red : Float64, green : Float64, blue : Float64

    def initialize(red, green, blue)
      @red = red.to_f
      @green = green.to_f
      @blue = blue.to_f
    end

    def color?
      true
    end

    def add(other : Color)
      Color.new(red + other.red, green + other.green, blue + other.blue)
    end

    def sub(other : Color)
      Color.new(red - other.red, green - other.green, blue - other.blue)
    end

    def hadamard_product(other : Color)
      Color.new(red * other.red, green * other.green, blue * other.blue)
    end

    def mul(other : Color)
      hadamard_product(other)
    end

    def mul(scalar)
      Color.new(red * scalar, green * scalar, blue * scalar)
    end
  end
end
