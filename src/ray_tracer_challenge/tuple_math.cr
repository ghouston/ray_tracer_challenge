struct Float64
  def mul(tuple : Tuple(T, T, T, T))
    {
      self * tuple[0],
      self * tuple[1],
      self * tuple[2],
      self * tuple[3],
    }
  end

  def mul(tuple : Tuple(T, T, T))
    {
      self * tuple[0],
      self * tuple[1],
      self * tuple[2],
    }
  end
end

module RayTracerChallenge
  # common math operations shared by Point and Vector
  module TupleMath
    module ClassMethods
    end

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
    def add(other : Tuple(T, T, T, T)) forall T
      {
        self.x + other.x,
        self.y + other.y,
        self.z + other.z,
        self.w + other.w,
      }
    end

    def sub(other : Tuple(T, T, T, T)) forall T
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

    def mul(scalar)
      # Crystal note: had trouble defining different versions of mul
      # which could handle different length tuples directly on the
      # tuple class.  Using double dispatch is a good work around
      # since I can specify the T of the argument to a method.
      scalar.to_f.mul(self)
    end

    def mul(tuple : Tuple(T, T, T, T)) forall T
      {
        self.x * other.x,
        self.y * other.y,
        self.z * other.z,
        self.w * other.w,
      }
    end

    def div(scalar)
      s = scalar.to_f
      {
        self.x / s,
        self.y / s,
        self.z / s,
        self.w / s,
      }
    end
  end
end
