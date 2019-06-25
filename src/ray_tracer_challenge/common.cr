RTC = RayTracerChallenge

module RayTracerChallenge
  # Common code shared by Point and Vector
  abstract struct Common
    getter x : Float64, y : Float64, z : Float64, w

    def initialize(x, y, z)
      @x = x.to_f
      @y = y.to_f
      @z = z.to_f
    end

    # note: maybe use #neg or #negate instead?
    def -
      self.class.new(-x, -y, -z)
    end

    def add(other : Common)
      if vector? && other.vector?
        Vector.new(x + other.x, y + other.y, z + other.z)
      else
        Point.new(x + other.x, y + other.y, z + other.z)
      end
    end

    def point?
      false
    end

    def vector?
      false
    end

    def mul(scalar)
      self.class.new(x * scalar, y * scalar, z * scalar)
    end

    def sub(other : Common)
      if vector? && other.vector? ||
         point? && other.point?
        Vector.new(x - other.x, y - other.y, z - other.z)
      else
        Point.new(x - other.x, y - other.y, z - other.z)
      end
    end

    def div(scalar)
      s = scalar.to_f
      self.class.new(
        self.x / s,
        self.y / s,
        self.z / s,
      )
    end
  end
end
