module RayTracerChallenge
  # separates the transform matrix
  # into a module to mix into SquareMatrix
  module Transform
    module Extensions
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

      def rotation_x(x_radians : Float64)
        SquareMatrix.new(4,
          1, 0, 0, 0,
          0, Math.cos(x_radians), -Math.sin(x_radians), 0,
          0, Math.sin(x_radians), Math.cos(x_radians), 0,
          0, 0, 0, 1)
      end

      def rotation_y(y_radians : Float64)
        SquareMatrix.new(4,
          Math.cos(y_radians), 0, Math.sin(y_radians), 0,
          0, 1, 0, 0,
          -Math.sin(y_radians), 0, Math.cos(y_radians), 0,
          0, 0, 0, 1)
      end

      def rotation_z(z_radians : Float64)
        SquareMatrix.new(4,
          Math.cos(z_radians), -Math.sin(z_radians), 0, 0,
          Math.sin(z_radians), Math.cos(z_radians), 0, 0,
          0, 0, 1, 0,
          0, 0, 0, 1)
      end
    end

    module Includes
      def todo
        puts "todo"
      end
    end

    module CoreExtensions
      module Float64
        def rotation_x
          SquareMatrix.rotation_x(self)
        end

        def rotation_y
          SquareMatrix.rotation_y(self)
        end

        def rotation_z
          SquareMatrix.rotation_z(self)
        end
      end
    end
  end
end
