require "./transform"

module RayTracerChallenge
  class SquareMatrix
    extend RayTracerChallenge::Transform

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

    def self.identity
      SquareMatrix.new(4,
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1)
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

    def mul(vector : Vector)
      result = mul(vector.to_tuple)
      Vector.new(result[0], result[1], result[2])
    end

    def transpose
      result = SquareMatrix.new(4)
      (0...width).each do |row|
        (0...width).each do |col|
          result.write(col, row, at(row, col))
        end
      end
      result
    end

    def determinant
      if width == 2
        determinant_2_x_2
      else
        determinant_n_x_n
      end
    end

    private def determinant_2_x_2
      at(0, 0) * at(1, 1) - at(0, 1) * at(1, 0)
    end

    private def determinant_n_x_n
      result = 0.0
      (0...width).each do |col|
        result = result + at(0, col)*cofactor(0, col)
      end
      result
    end

    def submatrix(row, col)
      result = SquareMatrix.new(width - 1)
      (0...width).each do |source_row|
        next if source_row == row
        target_row = (source_row > row) ? source_row - 1 : source_row
        (0...width).each do |source_col|
          next if source_col == col
          target_col = (source_col > col) ? source_col - 1 : source_col
          result.write(target_row, target_col, at(source_row, source_col))
        end
      end
      result
    end

    def minor(row, col)
      submatrix(row, col).determinant
    end

    def cofactor(row, col)
      if (row + col).even?
        minor(row, col)
      else
        -minor(row, col)
      end
    end

    def invertable?
      determinant != 0
    end

    def inverse
      d = determinant
      raise ArgumentError.new("cant invert this matrix, determinant == 0") if d == 0
      result = SquareMatrix.new(width)
      (0...width).each do |row|
        (0...width).each do |col|
          result.write(col, row, cofactor(row, col)/d)
        end
      end
      result
    end
  end
end
