require "./spec_helper.cr"
require "math"

describe "multiply a point by a translation matrix" do
  transform = SquareMatrix.translation(5, -3, 2)
  point = {-3, 4, 5}.to_point
  expected = {2, 1, 7}.to_point

  it "moves the point" do
    transform.mul(point).should eq expected
  end
end

describe "multiply the inverse of a translation matrix" do
  transform = SquareMatrix.translation(5, -3, 2)
  inverse = transform.inverse
  point = {-3, 4, 5}.to_point
  expected = {-8, 7, 3}.to_point

  it "moves the point" do
    inverse.mul(point).should eq expected
  end
end

describe "multiply translation with a vector" do
  transform = SquareMatrix.translation(5, -3, 2)
  vector = {-3, 4, 5}.to_vector

  it "does not affect vectors" do
    transform.mul(vector).should eq vector
  end
end

describe "scaling matrix applied to a point" do
  transform = SquareMatrix.scaling(2, 3, 4)
  point = {-4, 6, 8}.to_point
  expected = {-8, 18, 32}.to_point

  it "expands the point away from the origin" do
    transform.mul(point).should eq expected
  end
end

describe "scaling matrix applied to a vector" do
  transform = SquareMatrix.scaling(2, 3, 4)
  vector = {-4, 6, 8}.to_vector
  expected = {-8, 18, 32}.to_vector

  it "changes the size of the vector" do
    transform.mul(vector).should eq expected
  end
end

describe "inverse scaling matrix applied to a vector" do
  transform = SquareMatrix.scaling(2, 3, 4)
  inverse = transform.inverse
  vector = {-4, 6, 8}.to_vector
  expected = {-2, 2, 2}.to_vector

  it "changes the size of the vector" do
    inverse.mul(vector).should eq expected
  end
end

describe "reflection is scaling by a negative value" do
  transform = SquareMatrix.scaling(-1, 1, 1)
  point = {2, 3, 4}.to_point
  expected = {-2, 3, 4}.to_point

  it "expands the point away from the origin" do
    transform.mul(point).should eq expected
  end
end

describe "rotating a point around the x axis" do
  point = {0, 1, 0}.to_point
  half_quarter = (Math::PI/4).rotation_x
  full_quarter = (Math::PI/2.0).rotation_x
  expected_half = {0, Math.sqrt(2)/2, Math.sqrt(2)/2}.to_point
  expected_full = {0, 0, 1}.to_point

  it "moves using left-hand rule" do
    half_quarter.mul(point).should eq_point expected_half, delta: 1e-15
    full_quarter.mul(point).should eq_point expected_full, delta: 1e-15
  end
end

describe "rotating a point around the y axis" do
  point = {0, 0, 1}.to_point
  half_quarter = (Math::PI/4).rotation_y
  full_quarter = (Math::PI/2.0).rotation_y
  expected_half = {Math.sqrt(2)/2, 0, Math.sqrt(2)/2}.to_point
  expected_full = {1, 0, 0}.to_point

  it "moves using left-hand rule" do
    half_quarter.mul(point).should eq_point expected_half, delta: 1e-15
    full_quarter.mul(point).should eq_point expected_full, delta: 1e-15
  end
end

describe "rotating a point around the z axis" do
  point = {0, 1, 0}.to_point
  half_quarter = (Math::PI/4).rotation_z
  full_quarter = (Math::PI/2.0).rotation_z
  expected_half = {-Math.sqrt(2)/2, Math.sqrt(2)/2, 0}.to_point
  expected_full = {-1, 0, 0}.to_point

  it "moves using left-hand rule" do
    half_quarter.mul(point).should eq_point expected_half, delta: 1e-15
    full_quarter.mul(point).should eq_point expected_full, delta: 1e-15
  end
end

describe "a skew transformation" do
  point = {2, 3, 4}.to_point

  it "moves x in proportion to y" do
    transform = SquareMatrix.skew(1, 0, 0, 0, 0, 0)
    transform.mul(point).should eq Point.new(5, 3, 4)
  end

  it "moves x in proportion to z" do
    transform = SquareMatrix.skew(0, 1, 0, 0, 0, 0)
    transform.mul(point).should eq Point.new(6, 3, 4)
  end

  it "moves y in proportion to x" do
    transform = SquareMatrix.skew(0, 0, 1, 0, 0, 0)
    transform.mul(point).should eq Point.new(2, 5, 4)
  end

  it "moves y in proportion to z" do
    transform = SquareMatrix.skew(0, 0, 0, 1, 0, 0)
    transform.mul(point).should eq Point.new(2, 7, 4)
  end

  it "moves z in proportion to x" do
    transform = SquareMatrix.skew(0, 0, 0, 0, 1, 0)
    transform.mul(point).should eq Point.new(2, 3, 6)
  end

  it "moves z in proportion to y" do
    transform = SquareMatrix.skew(0, 0, 0, 0, 0, 1)
    transform.mul(point).should eq Point.new(2, 3, 7)
  end
end

describe "chaining transforms" do
  point = {1, 0, 1}.to_point
  rotation = (Math::PI/2).rotation_x
  scaling = SquareMatrix.scaling(5, 5, 5)
  translation = SquareMatrix.translation(10, 5, 7)

  it "applies in a specific order" do
    point2 = rotation.mul(point)
    point2.should eq_point Point.new(1, -1, 0), 1e-15

    point3 = scaling.mul(point2)
    point3.should eq_point Point.new(5, -5, 0), 1e-15

    point4 = translation.mul(point3)
    point4.should eq_point Point.new(15, 0, 7), 1e-15
  end
end

describe "fluent chaining transforms" do
  point = {1, 0, 1}.to_point

  it "applies in specific order" do
    transform = SquareMatrix.identity
      .rotate_x(Math::PI/2)
      .scale(5, 5, 5)
      .translate(10, 5, 7)
    transform.mul(point).should eq_point Point.new(15, 0, 7), 1e-15
  end
end
