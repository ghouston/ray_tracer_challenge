module RayTracerChallenge
  VERSION = "0.1.0"

  module ClassMethods
    def point(x : Float64, y : Float64, z : Float64)
      {x, y, z, 1.0}
    end
  
    def vector(x : Float64, y : Float64, z : Float64)
      {x, y, z, 0.0}
    end
  end

  # for now, everything is implemented as extensions to the Tuple class.
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

struct Tuple
  # Crystal notes: #extend inserts into the meta-type ancestor chain
  # and thus it is used to add class methods. #include inserts into
  # the type hierarchy, adding instance methods.
  # ref: https://github.com/crystal-lang/crystal/issues/5082
  extend RayTracerChallenge::ClassMethods
  include RayTracerChallenge
end
