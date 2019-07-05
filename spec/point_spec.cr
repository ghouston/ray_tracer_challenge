require "./spec_helper"

describe "Point struct" do
  describe "A tuple with w=1.0 is a point" do
    a = {4.3, -4.2, 3.1}.to_point

    it "#{a} should pass" do
      a.x.should eq 4.3
      a.y.should eq -4.2
      a.z.should eq 3.1
      a.w.should eq 1
      a.vector?.should be_false
      a.point?.should be_true
    end
  end

  describe ".to_tuple returns tuples with w = 1.0" do
    p = Point.new(4, -4, 3)
    expected = {4, -4, 3, 1}

    it "is #{expected}" do
      p.to_tuple.should eq expected
    end
  end

  describe "Adding two points" do
    p1 = {3.0, -2.0, 5.0}.to_point
    p2 = {-2.0, 3.0, 1.0}.to_point

    expected = {1.0, 1.0, 6.0}.to_point

    it "adds each element, returns a point" do
      p1.add(p2).should eq expected
      typeof(p1.add(p2)).should eq Point
    end
  end

  describe "Adding point and vector" do
    p1 = {3.0, -2.0, 5.0}.to_point
    v2 = {-2.0, 3.0, 1.0}.to_vector
    expected = {1.0, 1.0, 6.0}.to_point

    it "adds each element, returns a point" do
      p1.add(v2).should eq expected
      typeof(p1.add(v2)).should eq Point
    end
  end

  describe "Subtracting two points" do
    p1 = Point.new(3, 2, 1)
    p2 = Point.new(5, 6, 7)
    expected = Vector.new(-2, -4, -6)

    it "returns a vector" do
      p1.sub(p2).should eq expected
      typeof(p1.sub(p2)).should eq Vector
    end
  end

  describe "Subtracting a vector from a point" do
    p = Point.new(3, 2, 1)
    v = Vector.new(5, 6, 7)
    expected = Point.new(-2, -4, -6)

    it "returns another point" do
      p.sub(v).should eq expected
      typeof(p.sub(v)).should eq Point
    end
  end
end
