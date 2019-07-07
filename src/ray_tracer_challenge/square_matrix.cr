module RayTracerChallenge
  class SquareMatrix
    @matrix : Array(Array(Float64))
    getter width : Int32

    def initialize(@width, *args)
      @matrix = Array.new(height) { |_|
        Array.new(width, 0.0)
      }

      args.each_with_index do |a, i|
        row, col = to_row_col(i)
        @matrix[row][col] = a.to_f
      end
    end

    def at(row : Int32, col : Int32)
      @matrix[row][col]
    end

    def write(row : Int32, col : Int32, value : Float64)
      @matrix[row][col] = value
    end

    def to_row_col(i)
      [i / width, i % width]
    end

    def height
      width
    end

    def ==(other : SquareMatrix)
      return false if width != other.width

      @matrix.each_with_index do |row_data, row|
        row_data.each_with_index do |data, col|
          return false unless other.at(row, col).equivalent(data)
        end
      end

      true
    end

    def mul(other : SquareMatrix)
      if width != other.width
        raise ArgumentError.new("array sizes must match to perform multiplication")
      end

      result = SquareMatrix.new(width)

      (0...width).each do |row|
        (0...width).each do |col|
          total = 0.0
          (0...width).each do |i|
            total = total + at(row, i) * other.at(i, col)
          end

          result.write(row, col, total)
        end
      end

      result
    end

    def mul(tuple : Tuple)
      result = Array.new(4, 0.0)
      (0...width).each do |row|
        total = 0.0
        (0...width).each do |col|
          total = total + at(row, col) * tuple[col]
        end
        result[row] = total
      end
      {result[0], result[1], result[2], result[3]}
    end

    def mul(point : Point)
      result = mul(point.to_tuple)
      Point.new(result[0], result[1], result[2])
    end
  end
end
