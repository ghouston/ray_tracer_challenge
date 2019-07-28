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
