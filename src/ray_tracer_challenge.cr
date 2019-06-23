# TODO: Write documentation for `RayTracerChallenge`

struct Tuple
  def point?
    size == 4 && w == 1.0
  end

  def vector?
    size == 4 && w == 0.0
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

  def self.point(x : Float64, y : Float64, z : Float64)
    {x, y, z, 1.0}
  end

  def self.vector(x : Float64, y : Float64, z : Float64)
    {x, y, z, 0.0}
  end

  # note: probably needs to be a macro to allow different sized tuples.
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

  def magnitude
    (self.x**2 + self.y**2 + self.z**2 + self.w**2)**0.5
  end

  def normalize
    self.div(self.magnitude)
  end
end

module RayTracerChallenge
  VERSION = "0.1.0"
  EPSILON = 0.000001

  struct Tuple
    property x, y, z, w

    def initialize(@x : Float64, @y : Float64, @z : Float64, @w : Float64)
    end

    def point?
      return @w < (1.0 + EPSILON) && @w > (1.0 - EPSILON)
    end

    def vector?
      return @w < (0.0 + EPSILON) && @w > (0.0 - EPSILON)
    end
  end
end
