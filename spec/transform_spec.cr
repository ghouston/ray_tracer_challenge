require "./spec_helper.cr"

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
