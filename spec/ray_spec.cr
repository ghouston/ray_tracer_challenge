require "./spec_helper.cr"

describe "creating and querying a ray" do
  origin = {1, 2, 3}.to_point
  direction = {4, 5, 6}.to_vector
  ray = Ray.new(origin, direction)

  it "should" do
    ray.origin.should eq origin
    ray.direction.should eq direction
  end
end

describe "computing a point from a distance" do
  ray = Ray.new({2, 3, 4}.to_point, {1, 0, 0}.to_vector)

  it "finds the point after traveling some time" do
    ray.position(0).should eq Point.new(2, 3, 4)
    ray.position(1).should eq Point.new(3, 3, 4)
    ray.position(-1).should eq Point.new(1, 3, 4)
    ray.position(2.5).should eq Point.new(4.5, 3, 4)
  end
end

describe "a ray intersecting a sphere in the middle" do
  ray = Ray.new({0, 0, -5}.to_point, {0, 0, 1}.to_vector)
  sphere = Sphere.new

  it "intersects at two points" do
    result = ray.intersects(sphere)
    result.size.should eq 2
    result[0].t.should eq 4.0
    result[1].t.should eq 6.0
  end
end

describe "a ray intersecting a sphere at a tangent" do
  ray = Ray.new({0, 1, -5}.to_point, {0, 0, 1}.to_vector)
  sphere = Sphere.new

  it "intersects at two points, which are the same" do
    result = ray.intersects(sphere)
    result.size.should eq 2
    result[0].t.should eq 5.0
    result[1].t.should eq 5.0
  end
end

describe "a ray missing a sphere" do
  ray = Ray.new({0, 2, -5}.to_point, {0, 0, 1}.to_vector)
  sphere = Sphere.new

  it "intersects at no points" do
    result = ray.intersects(sphere)
    result.size.should eq 0
  end
end

describe "a ray staring inside a sphere" do
  ray = Ray.new({0, 0, 0}.to_point, {0, 0, 1}.to_vector)
  sphere = Sphere.new

  it "intersects at two points, one is behind the ray origin" do
    result = ray.intersects(sphere)
    result.size.should eq 2
    result[0].t.should eq -1.0
    result[1].t.should eq 1.0
  end
end

describe "a sphere behind the ray" do
  ray = Ray.new({0, 0, 5}.to_point, {0, 0, 1}.to_vector)
  sphere = Sphere.new

  it "intersects at two points behind the ray origin" do
    result = ray.intersects(sphere)
    result.size.should eq 2
    result[0].t.should eq -6.0
    result[1].t.should eq -4.0
  end
end

describe "translate a ray" do
  r = Ray.new({1, 2, 3}.to_point, {0, 1, 0}.to_vector)
  m = SquareMatrix.translation(3, 4, 5)
  r2 = r.transform(m)

  it "gives a new ray with origin moved" do
    r2.origin.should eq ({4, 6, 8}.to_point)
    r2.direction.should eq ({0, 1, 0}.to_vector)
    r2.should_not be(r)
  end

  it "doesn't change the original ray" do
    r.origin.should eq ({1, 2, 3}.to_point)
    r.direction.should eq ({0, 1, 0}.to_vector)
  end
end

describe "scaling a ray" do
  r = Ray.new({1, 2, 3}.to_point, {0, 1, 0}.to_vector)
  m = SquareMatrix.scaling(2, 3, 4)
  r2 = r.transform(m)

  it "gives a new ray with origin and direction scaled" do
    r2.origin.should eq ({2, 6, 12}.to_point)
    r2.direction.should eq ({0, 3, 0}.to_vector)
    r2.should_not be(r)
  end

  it "doesn't change the original ray" do
    r.origin.should eq ({1, 2, 3}.to_point)
    r.direction.should eq ({0, 1, 0}.to_vector)
  end
end

describe "intersect a scaled sphere with a ray" do
  r = Ray.new({0, 0, -5}.to_point, {0, 0, 1}.to_vector)
  s = Sphere.new(SquareMatrix.scaling(2, 2, 2))
  xs = r.intersects(s)

  it "transforms the ray before calculating the intersections" do
    xs.size.should eq 2
    xs[0].t.should eq 3
    xs[1].t.should eq 7
  end
end

describe "intersect a translated sphere with a ray" do
  r = Ray.new({0, 0, -5}.to_point, {0, 0, 1}.to_vector)
  s = Sphere.new(SquareMatrix.translation(5, 0, 0))
  xs = r.intersects(s)

  it "transforms the ray before calculating the intersections" do
    xs.size.should eq 0
  end
end
