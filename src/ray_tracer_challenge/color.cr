alias Color = Tuple(Float64, Float64, Float64)

module RayTracerChallenge
  module Color
    module ClassMethods
      def color(red, green, blue)
        {red.to_f, green.to_f, blue.to_f}
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

    def add(other : Tuple(T, T, T)) forall T
      {
        self.red + other.red,
        self.green + other.green,
        self.blue + other.blue,
      }
    end

    def sub(other : Tuple(T, T, T)) forall T
      {
        self.red - other.red,
        self.green - other.green,
        self.blue - other.blue,
      }
    end

    def hadamard_product(other : Tuple(T, T, T)) forall T
      {
        self.red * other.red,
        self.green * other.green,
        self.blue * other.blue,
      }
    end

    def mul(other : Tuple(T, T, T)) forall T
      hadamard_product(other)
    end
  end
end
