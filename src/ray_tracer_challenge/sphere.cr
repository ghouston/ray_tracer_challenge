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
  end
end
