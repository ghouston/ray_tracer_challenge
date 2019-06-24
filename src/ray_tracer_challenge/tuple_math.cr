module RayTracerChallenge
  # common math operations shared by Point and Vector
  module TupleMath
    def x
      self[0]
    end

    def y
      self[1]
    end

    def z
      self[2]
    end

    def w
      self[3]
    end

    # note: using #add instead of #+ which already exists.  #+ will concatenate
    def add(other : Tuple(Float64, Float64, Float64, Float64))
      {
        self.x + other.x,
        self.y + other.y,
        self.z + other.z,
        self.w + other.w,
      }
    end

    def sub(other : Tuple(Float64, Float64, Float64, Float64))
      {
        self.x - other.x,
        self.y - other.y,
        self.z - other.z,
        self.w - other.w,
      }
    end

    # note: maybe use #neg or #negate instead?
    def -
      {
        -self.x,
        -self.y,
        -self.z,
        -self.w,
      }
    end

    def mul(scalar : Float64)
      {
        self.x * scalar,
        self.y * scalar,
        self.z * scalar,
        self.w * scalar,
      }
    end

    def div(scalar : Float64)
      {
        self.x / scalar,
        self.y / scalar,
        self.z / scalar,
        self.w / scalar,
      }
    end
  end
end
