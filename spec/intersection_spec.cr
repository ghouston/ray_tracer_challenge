require "./spec_helper.cr"

describe "An intersection" do
  s = Sphere.new
  i = Intersection.new(3.5, s)

  it "encapsulates t and object" do
    i.t.should eq 3.5
    i.object.should eq s
  end
end

describe "#<=>" do
  i1 = Intersection.new(1, Sphere.new)
  i2 = Intersection.new(2, Sphere.new)
  i2b = Intersection.new(2, Sphere.new)
  i3 = Intersection.new(-3, Sphere.new)
  it " compares t values" do
    (i1 <=> i2).should eq -1
    (i2 <=> i1).should eq 1
    (i2 <=> i2b).should eq 0
    (i3 <=> i2).should eq -1
    (i2 <=> i3).should eq 1
  end
end
