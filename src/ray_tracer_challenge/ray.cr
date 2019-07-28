module RayTracerChallenge
  class Ray
    getter origin : Point, direction : Vector

    def initialize(@origin, @direction)
    end

    def position(ticks)
      origin.add(direction.mul(ticks.to_f))
    end

    def intersects(sphere : Sphere)
      sphere_to_ray = origin.sub({0, 0, 0}.to_point)
      a = direction.dot(direction)
      b = 2.0 * direction.dot(sphere_to_ray)
      c = sphere_to_ray.dot(sphere_to_ray) - 1.0
      discriminant = (b * b) - (4.0 * a * c)

      if discriminant < 0.0
        result = Intersections.new
      else
        t1 = (-b - Math.sqrt(discriminant)) / (2.0 * a)
        t2 = (-b + Math.sqrt(discriminant)) / (2.0 * a)
        result = Intersections.new(
          Intersection.new(t1, sphere),
          Intersection.new(t2, sphere)
        )
      end
      result
    end
  end
end
