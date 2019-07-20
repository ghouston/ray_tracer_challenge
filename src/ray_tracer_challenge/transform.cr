module RayTracerChallenge
  # separates the transform matrix
  # into a module to mix into SquareMatrix
  module Transform
    module Extensions
      def translation(x, y, z)
        SquareMatrix.new(4,
          1, 0, 0, x.to_f,
          0, 1, 0, y.to_f,
          0, 0, 1, z.to_f,
          0, 0, 0, 1)
      end

      def scaling(x, y, z)
        SquareMatrix.new(4,
          x.to_f, 0, 0, 0,
          0, y.to_f, 0, 0,
          0, 0, z.to_f, 0,
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

      def skew(x_to_y, x_to_z, y_to_x, y_to_z, z_to_x, z_to_y)
        SquareMatrix.new(4,
          1, x_to_y.to_f, x_to_z.to_f, 0,
          y_to_x.to_f, 1, y_to_z.to_f, 0,
          z_to_x.to_f, z_to_y.to_f, 1, 0,
          0, 0, 0, 1)
      end
    end

    module Includes
      def translate(x, y, z)
        SquareMatrix.translation(x, y, z).mul(self)
      end

      def scale(x, y, z)
        SquareMatrix.scaling(x, y, z).mul(self)
      end

      def rotate_x(x)
        x.rotation_x.mul(self)
      end

      def rotate_y(y)
        y.rotation_y.mul(self)
      end

      def rotate_z(z)
        z.rotation_z.mul(self)
      end

      def skew(x_to_y = 0, x_to_z = 0, y_to_x = 0, y_to_z = 0, z_to_x = 0, z_to_y = 0)
        SquareMatrix
          .skew(x_to_y, x_to_z, y_to_x, y_to_z, z_to_x, z_to_y)
          .mul(self)
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
