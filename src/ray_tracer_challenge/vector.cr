module RayTracerChallenge
  module Vector
    module ClassMethods
      def vector(x : Float64, y : Float64, z : Float64)
        {x, y, z, 0.0}
      end
    end

    def vector?
      size == 4 && w == 0.0
    end

    def magnitude
      (self.x**2 + self.y**2 + self.z**2 + self.w**2)**0.5
    end

    def normalize
      self.div(self.magnitude)
    end

    def dot(other : Tuple(Float64, Float64, Float64, Float64))
      self.x * other.x +
        self.y * other.y +
        self.z * other.z +
        self.w * other.w
    end

    def cross(other : Tuple(Float64, Float64, Float64, Float64))
      Tuple.vector(
        self.y * other.z - self.z * other.y,
        self.z * other.x - self.x * other.z,
        self.x * other.y - self.y * other.x
      )
    end
  end
end
