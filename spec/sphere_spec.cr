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

describe "surface normals" do
  s = Sphere.new

  it "is found at a point on the x-axis" do
    n = s.normal_at({1, 0, 0}.to_point)
    n.should eq Vector.new(1, 0, 0)
  end

  it "is found at a point on the y-axis" do
    n = s.normal_at({0, 1, 0}.to_point)
    n.should eq Vector.new(0, 1, 0)
  end

  it "is found at a point on the z-axis" do
    n = s.normal_at({0, 0, 1}.to_point)
    n.should eq Vector.new(0, 0, 1)
  end

  it "is found at a none axial point" do
    x = y = z = Math.sqrt(3)/3
    n = s.normal_at({x, y, z}.to_point)
    n.should eq Vector.new(x, y, z)
  end

  it "is a normalized vector" do
    x = y = z = Math.sqrt(3)/3
    n = s.normal_at({x, y, z}.to_point)
    n.should eq (n.normalize)
  end
end

describe "computing the normal on a translated sphere" do
  s = Sphere.new(SquareMatrix.identity.translate(0, 1, 0))

  it "is not impacted by the translation" do
    n = s.normal_at({0, 1.70711, -0.70711}.to_point)
    n.should eq_vector Vector.new(0, 0.70711, -0.70711), 0.00001
  end
end

describe "computing the normal on a transformed sphere" do
  s = Sphere.new(SquareMatrix.identity.rotate_z(Math::PI/5).scale(1, 0.5, 1))

  it "is not impacted by the translation" do
    y = z = Math.sqrt(2)/2
    n = s.normal_at({0, y, -z}.to_point)
    n.should eq_vector Vector.new(0, 0.97014, -0.24254), 0.00001
  end
end
