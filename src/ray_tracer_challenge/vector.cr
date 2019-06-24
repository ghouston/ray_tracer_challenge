module RayTracerChallenge
  module Vector
    module ClassMethods
      def vector(x, y, z)
        {x.to_f, y.to_f, z.to_f, 0.0}
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

    def dot(other : Tuple(T, T, T, T)) forall T
      self.x * other.x +
        self.y * other.y +
        self.z * other.z +
        self.w * other.w
    end

    def cross(other : Tuple(T, T, T, T)) forall T
      Tuple.vector(
        self.y * other.z - self.z * other.y,
        self.z * other.x - self.x * other.z,
        self.x * other.y - self.y * other.x
      )
    end
  end
end
