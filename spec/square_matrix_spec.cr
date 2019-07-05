require "./spec_helper.cr"

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
end

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
