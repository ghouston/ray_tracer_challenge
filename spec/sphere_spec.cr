require "./spec_helper"

describe "a sphere's default transformation" do
  s = Sphere.new

  it "is an identity matrix" do
    s.transform.should eq SquareMatrix.identity
    s.inverse_transform.should eq SquareMatrix.identity
  end
end

describe "changing a sphere's transformation" do
  s = Sphere.new
  original_transform = s.transform
  original_inverse = s.inverse_transform
  s.transform = SquareMatrix.translation(1, 2, 3)

  it "updates the transform" do
    s.transform.should_not eq_matrix original_transform
    s.transform.should eq_matrix SquareMatrix.translation(1, 2, 3)
  end

  it "changes the inverse_transform" do
    s.inverse_transform.should_not eq_matrix original_inverse
    s.inverse_transform.should eq SquareMatrix.translation(-1, -2, -3)
  end
end
