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
      a.mul(b).should eq_matrix expected
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

    it "results in a tuple" do
      a.mul(b).should eq expected
    end
  end

  describe "multiplication of a matrix by a vector" do
    a = SquareMatrix.new(4,
      1, 2, 3, 4,
      2, 4, 4, 2,
      8, 6, 4, 1,
      0, 0, 0, 1)
    b = {1, 2, 3}.to_vector
    expected = Vector.new(14, 22, 32)

    it "results in a vector" do
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
      result.should eq_matrix a
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

      a.transpose.should eq_matrix expected
    end
  end

  describe "transposing the identity matrix" do
    a = SquareMatrix.identity

    it "results in an identity matrix" do
      a.transpose.should eq_matrix SquareMatrix.identity
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

      a.submatrix(0, 2).should eq_matrix expected
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

      a.submatrix(2, 1).should eq_matrix expected
    end
  end

  describe "calculating a minor of a 3x3 matrix" do
    a = SquareMatrix.new(3,
      3, 5, 0,
      2, -1, -7,
      6, -1, 5)

    it "follows these caluculations" do
      b = a.submatrix(1, 0)
      b.determinant.should eq 25
      a.minor(1, 0).should eq 25
    end
  end

  describe "compute the cofactor of a 3x3 matrix" do
    a = SquareMatrix.new(3,
      3, 5, 0,
      2, -1, -7,
      6, -1, 5)

    it "is == minor if row+col is an even number" do
      a.minor(0, 0).should eq -12
      a.cofactor(0, 0).should eq -12
    end

    it "is -minor if row+col is an odd number" do
      a.minor(1, 0).should eq 25
      a.cofactor(1, 0).should eq -25
    end
  end

  describe "calc the determinant of a 3x3 matrix" do
    a = SquareMatrix.new(3,
      1, 2, 6,
      -5, 8, -4,
      2, 6, 4)

    it "sums (elements x cofactor) for a single row or column" do
      a.cofactor(0, 0).should eq 56
      a.cofactor(0, 1).should eq 12
      a.cofactor(0, 2).should eq -46
      a.determinant.should eq -196 # eg. 56*1 + 12*6 + -46*6
    end
  end

  describe "calc the determinant of a 4x4 matrix" do
    a = SquareMatrix.new(4,
      -2, -8, 3, 5,
      -3, 1, 7, 3,
      1, 2, -9, 6,
      -6, 7, 7, -9)

    it "sums (elements x cofactor) for a single row or column" do
      a.cofactor(0, 0).should eq 690
      a.cofactor(0, 1).should eq 447
      a.cofactor(0, 2).should eq 210
      a.cofactor(0, 3).should eq 51
      a.determinant.should eq -4071
    end
  end

  describe "testing invertability of a matrix" do
    describe "for an invertable matrix" do
      a = SquareMatrix.new(4,
        6, 4, 4, 4,
        5, 5, 7, 6,
        4, -9, 3, -7,
        9, 1, 7, -6)

      it "is invertable because the determinant is not zero" do
        a.determinant.should eq -2120
        a.invertable?.should be_true
      end
    end

    describe "for a noninvertable matrix" do
      a = SquareMatrix.new(4,
        -4, 2, -2, -3,
        9, 6, 2, 6,
        0, -5, 1, -5,
        0, 0, 0, 0)

      it "is not invertable because the determinant is zero" do
        a.determinant.should eq 0
        a.invertable?.should be_false
      end
    end
  end

  describe "calculate the inverse of a matrix" do
    a = SquareMatrix.new(4,
      -5, 2, 6, -8,
      1, -5, 1, 8,
      7, 7, -6, -7,
      1, -3, 7, 4)

    it "finds cofactor/determinant of each element transposed around the diagnal" do
      b = a.inverse
      a.determinant.should eq 532
      a.cofactor(2, 3).should eq -160
      b.at(3, 2).should eq -160.0/532.0
      a.cofactor(3, 2).should eq 105
      b.at(2, 3).should eq 105.0/532.0

      d = a.determinant
      expected = SquareMatrix.new(4,
        116/d, 240/d, 128/d, -24/d,
        -430/d, -775/d, -236/d, 277/d,
        -42/d, -119/d, -28/d, 105/d,
        -278/d, -433/d, -160/d, 163/d)
      b.should eq_matrix expected
    end
  end

  describe "calculate the inverse of a second matrix" do
    a = SquareMatrix.new(4,
      8, -5, 9, 2,
      7, 5, 6, 1,
      -6, 0, 9, 6,
      -3, 0, -9, -4)

    it "results in" do
      d = a.determinant
      expected = SquareMatrix.new(4,
        90/d, 90/d, 165/d, 315/d,
        45/d, -72/d, -15/d, -18/d,
        -210/d, -210/d, -255/d, -540/d,
        405/d, 405/d, 450/d, 1125/d)
      a.inverse.should eq_matrix expected
    end
  end

  describe "calculate the inverse of a third matrix" do
    a = SquareMatrix.new(4,
      9, 3, 0, 9,
      -5, -2, -6, -3,
      -4, 9, 6, 4,
      -7, 6, 6, 2)

    it "results in" do
      d = a.determinant
      expected = SquareMatrix.new(4,
        -66/d, -126/d, 234/d, -360/d,
        -126/d, 54/d, 594/d, -540/d,
        -47/d, -237/d, -177/d, 210/d,
        288/d, 108/d, -432/d, 540/d)
      a.inverse.should eq_matrix expected
    end
  end

  describe "multiply a product by its inverse" do
    a = SquareMatrix.new(4,
      3, -9, 7, 3,
      3, -8, 2, -9,
      -4, 4, 4, 1,
      -6, 5, -1, 1)
    b = SquareMatrix.new(4,
      8, 2, 2, 2,
      3, -1, 7, 0,
      7, 0, 5, 4,
      6, -2, 0, 5)
    c = a.mul(b)

    it "returns the original matrix" do
      c.mul(b.inverse).should eq_matrix a, delta: 1.0e-14
    end
  end
end
