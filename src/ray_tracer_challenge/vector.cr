module RayTracerChallenge
  struct Vector < Common
    @w = 0.0

    def cross(other : Vector)
      Vector.new(
        y * other.z - z * other.y,
        z * other.x - x * other.z,
        x * other.y - y * other.x
      )
    end

    def dot(other : Vector)
      x * other.x +
        y * other.y +
        z * other.z
    end

    def magnitude
      (x**2 + y**2 + z**2 + w**2)**0.5
    end

    def normalize
      div(magnitude)
    end

    def to_tuple
      {x, y, z, w}
    end

    def vector?
      true
    end
  end
end
