module RayTracerChallenge
  class Sphere
    getter transform : SquareMatrix
    getter inverse_transform : SquareMatrix

    def initialize(transform = SquareMatrix.identity)
      @transform = transform
      @inverse_transform = transform.inverse
    end

    def transform=(transform : SquareMatrix)
      @transform = transform
      @inverse_transform = transform.inverse
    end

    def normal_at(surface_point : Point)
      object_point = @inverse_transform.mul(surface_point)
      object_normal = object_point.sub(Point.origin)
      world_normal = @inverse_transform.transpose.mul(object_normal)
      world_normal.ensure_vector
      world_normal.normalize
    end
  end
end
