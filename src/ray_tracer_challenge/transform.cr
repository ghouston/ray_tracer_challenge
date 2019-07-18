module RayTracerChallenge
  # separates the transform matrix
  # into a module to mix into SquareMatrix
  module Transform
    def translation(x : Float64, y : Float64, z : Float64)
      SquareMatrix.new(4,
        1, 0, 0, x,
        0, 1, 0, y,
        0, 0, 1, z,
        0, 0, 0, 1)
    end

    def scaling(x : Float64, y : Float64, z : Float64)
      SquareMatrix.new(4,
        x, 0, 0, 0,
        0, y, 0, 0,
        0, 0, z, 0,
        0, 0, 0, 1)
    end
  end
end
