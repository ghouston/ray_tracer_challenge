require "./spec_helper.cr"

describe "Matrix 2x2" do
  describe "constructing a 2x2 matrix" do
    m = SquareMatrix.new(2,
      -3, 5,
      1, -2)

    it "should" do
      m.at(0, 0).should eq -3
      m.at(0, 1).should eq 5
      m.at(1, 0).should eq 1
      m.at(1, 1).should eq -2
    end
  end
end

describe "Matrix 3x3" do
  describe "constructing a 3x3 matrix" do
    m = SquareMatrix.new(3, -3, 5, 0, 1, -2, -7, 0, 1, 1)

    it "should" do
      m.at(0, 0).should eq -3
      m.at(1, 1).should eq -2
      m.at(2, 2).should eq 1
    end
  end
end

describe "Matrix 4x4" do
  describe "constructing a 4x4 matrix" do
    a = SquareMatrix.new(4,
      1, 2, 3, 4,
      5.5, 6.5, 7.5, 8.5,
      9, 10, 11, 12,
      13.5, 14.5, 15.5, 16.5
    )

    it "should:" do
      a.at(0, 0).should eq 1
      a.at(0, 3).should eq 4
      a.at(1, 0).should eq 5.5
      a.at(1, 2).should eq 7.5
      a.at(2, 2).should eq 11
      a.at(3, 0).should eq 13.5
      a.at(3, 2).should eq 15.5
    end
  end

  describe "comparing same size matrices" do
    a = SquareMatrix.new(4,
      1, 2, 3, 4,
      5, 6, 7, 8,
      9, 8, 7, 6,
      5, 4, 3, 2)
    b = SquareMatrix.new(4,
      1, 2, 3, 4,
      5, 6, 7, 8,
      9, 8, 7, 6,
      5, 4, 3, 2)
    c = SquareMatrix.new(4,
      2, 3, 4, 5,
      6, 7, 8, 9,
      8, 7, 6, 5,
      4, 3, 2, 1)

    it "a and b compare as equal" do
      (a == b).should be_true
      (b == a).should be_true
    end

    it "a and c compare as not equal" do
      (a == c).should be_false
      (c == a).should be_false
    end
  end

  describe "comparing different size matrices" do
    a = SquareMatrix.new(2,
      1, 2,
      5, 6,
    )
    b = SquareMatrix.new(3,
      1, 2, 3,
      5, 6, 7,
      9, 8, 8)

    it "a and b compare as not equal" do
      (a == b).should be_false
      (b == a).should be_false
    end
  end

  describe "multiplication of two matricies" do
    a = SquareMatrix.new(4,
      1, 2, 3, 4,
      5, 6, 7, 8,
      9, 8, 7, 6,
      5, 4, 3, 2)
    b = SquareMatrix.new(4,
      -2, 1, 2, 3,
      3, 2, 1, -1,
      4, 3, 6, 5,
      1, 2, 7, 8)

    it "results in this matrix" do
      expected = SquareMatrix.new(4,
        20, 22, 50, 48,
        44, 54, 114, 108,
        40, 58, 110, 102,
        16, 26, 46, 42)
      a.mul(b).should eq expected
    end
  end

  describe "multiplication of a matrix by a point" do
    a = SquareMatrix.new(4,
      1, 2, 3, 4,
      2, 4, 4, 2,
      8, 6, 4, 1,
      0, 0, 0, 1)
    b = {1, 2, 3}.to_point
    expected = Point.new(18, 24, 33)

    it "results in a point" do
      a.mul(b).should eq expected
    end
  end

  describe "multiplication of a matrix by a tuple" do
    a = SquareMatrix.new(4,
      1, 2, 3, 4,
      2, 4, 4, 2,
      8, 6, 4, 1,
      0, 0, 0, 1)
    b = {1, 2, 3, 1}
    expected = Tuple.new(18, 24, 33, 1)

    it "results in a point" do
      a.mul(b).should eq expected
    end
  end

  describe "multiplication by identity matrix" do
    a = SquareMatrix.new(4,
      0, 1, 2, 4,
      1, 2, 4, 8,
      2, 4, 8, 16,
      4, 8, 16, 32)

    it "results in matrix with the same values" do
      result = a.mul(SquareMatrix.identity)
      result.should eq a
      result.should_not be(a)
    end
  end

  describe "multiplication of identity matrix by a tuple" do
    t = {1, 2, 3, 4}

    it "results in tuple with the same values" do
      SquareMatrix.identity.mul(t).should eq t
    end
  end

  describe "transposing a matrix" do
    a = SquareMatrix.new(4,
      1, 2, 3, 4,
      5, 6, 7, 8,
      9, 10, 11, 12,
      13, 14, 15, 16)

    it "turns rows into columns" do
      expected = SquareMatrix.new(4,
        1, 5, 9, 13,
        2, 6, 10, 14,
        3, 7, 11, 15,
        4, 8, 12, 16)

      a.transpose.should eq expected
    end
  end

  describe "transposing the identity matrix" do
    a = SquareMatrix.identity

    it "results in an identity matrix" do
      a.transpose.should eq SquareMatrix.identity
    end
  end

  describe "determinant of a 2x2 matrix" do
    a = SquareMatrix.new(2,
      1, 5,
      -3, 2)

    it "should" do
      a.determinant.should eq 17.0
    end
  end

  describe "a submatrix of a 3x3 matrix is a 2x2 matrix" do
    a = SquareMatrix.new(3,
      1, 5, 0,
      -3, 2, 7,
      0, 6, -3)

    it "skips the given row and col" do
      expected = SquareMatrix.new(2,
        -3, 2,
        0, 6)

      a.submatrix(0, 2).should eq expected
    end
  end

  describe "a submatrix of a 4x4 matrix is a 3x3 matrix" do
    a = SquareMatrix.new(4,
      -6, 1, 1, 6,
      -8, 5, 8, 6,
      -1, 0, 8, 2,
      -7, 1, -1, 1)

    it "removes the given row and col" do
      expected = SquareMatrix.new(3,
        -6, 1, 6,
        -8, 8, 6,
        -7, -1, 1)

      a.submatrix(2, 1).should eq expected
    end
  end
end
