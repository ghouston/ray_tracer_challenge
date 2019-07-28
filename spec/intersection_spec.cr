require "./spec_helper.cr"

describe "An intersection" do
  s = Sphere.new
  i = Intersection.new(3.5, s)

  it "encapsulates t and object" do
    i.t.should eq 3.5
    i.object.should eq s
  end
end

describe "Aggregating intersections" do
  s = Sphere.new
  i1 = Intersection.new(1, s)
  i2 = Intersection.new(2, s)
  xs = Intersections.new(i1, i2)

  it "collects multiple intersection objects" do
    xs.size.should eq 2
    xs[0].t.should eq 1
    xs[1].t.should eq 2
  end
end

describe "Ray#intersect returns Intersections" do
  r = Ray.new({0, 0, -5}.to_point, {0, 0, 1}.to_vector)
  s = Sphere.new
  xs = r.intersects(s)

  it "sets the object on the intersection" do
    xs.size.should eq 2
    xs[0].object.should eq s
    xs[1].object.should eq s
  end
end
