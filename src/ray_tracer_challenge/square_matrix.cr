module RayTracerChallenge
  class SquareMatrix
    @matrix : Array(Array(Float64))
    getter width : Int32

    def initialize(@width, *args)
      @matrix = Array.new(height) { |_|
        Array.new(width, 0.0)
      }

      args.each_with_index do |a, i|
        x, y = to_x_y(i)
        @matrix[x][y] = a.to_f
      end
    end

    def at(x : Int32, y : Int32)
      @matrix[x][y]
    end

    def to_x_y(i)
      [i / width, i % width]
    end

    def height
      width
    end
  end
end
