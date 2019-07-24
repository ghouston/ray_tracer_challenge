module RayTracerChallenge
  class Ray
    getter origin : Point, direction : Vector

    def initialize(@origin, @direction)
    end

    def position(ticks)
      origin.add(direction.mul(ticks.to_f))
    end

    def intersects(sphere : Sphere)
      [0.0, 0.0]
    end
  end
end
