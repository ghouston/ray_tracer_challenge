module RayTracerChallenge
  struct Point < Common
    @w = 1.0

    def point?
      true
    end

    def to_tuple
      {x, y, z, w}
    end

    def add(other : Point | Vector)
      Point.new(x + other.x, y + other.y, z + other.z)
    end

    def sub(p : Point)
      Vector.new(x - p.x, y - p.y, z - p.z)
    end

    def sub(v : Vector)
      Point.new(x - v.x, y - v.y, z - v.z)
    end
  end
end
