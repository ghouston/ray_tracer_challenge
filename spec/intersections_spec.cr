require "./spec_helper.cr"

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

describe "the hit" do
  s = Sphere.new

  describe "when all intersections have positive t" do
    i1 = Intersection.new(1, s)
    i2 = Intersection.new(2, s)
    xs = Intersections.new(i1, i2)

    it "hits the min t" do
      xs.hit.should eq i1
    end
  end

  describe "when some intersections have negative t" do
    i1 = Intersection.new(-1, s)
    i2 = Intersection.new(1, s)
    xs = Intersections.new(i1, i2)

    it "hits the min t where t is positive" do
      xs.hit.should eq i2
    end
  end

  describe "when all intersections are negative t" do
    i1 = Intersection.new(-2, s)
    i2 = Intersection.new(-1, s)
    xs = Intersections.new(i1, i2)

    it "hits nothing" do
      xs.hit.should eq nil
    end
  end
  describe "when t is positive and negative mix" do
    i1 = Intersection.new(5, s)
    i2 = Intersection.new(7, s)
    i3 = Intersection.new(-3, s)
    i4 = Intersection.new(2, s)
    i5 = Intersection.new(-9, s)
    xs = Intersections.new(i1, i2, i3, i4, i5)

    it "the lowest positive t intersection" do
      xs.hit.should eq i4
    end
  end
end
