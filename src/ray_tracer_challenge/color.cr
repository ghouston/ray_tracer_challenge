module RayTracerChallenge
  module Color
    module ClassMethods
      def color(red : Float64, green : Float64, blue : Float64)
        {red, green, blue}
      end
    end

    def color?
      size == 3
    end

    def red
      self[0]
    end

    def green
      self[1]
    end

    def blue
      self[2]
    end

    def add(other : Tuple(Float64, Float64, Float64))
      {
        self.red + other.red,
        self.green + other.green,
        self.blue + other.blue,
      }
    end

    def sub(other : Tuple(Float64, Float64, Float64))
      {
        self.red - other.red,
        self.green - other.green,
        self.blue - other.blue,
      }
    end

    # TODO: how to make #mul that works with vectors and colors?
    def color_mul(scalar : Float64)
      {
        self.red * scalar,
        self.green * scalar,
        self.blue * scalar,
      }
    end
  end
end
