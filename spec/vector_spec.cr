require "./spec_helper"

describe "Vector struct" do
  describe "#to_vector gives w=0, which is a vector" do
    a = {4.3, -4.2, 3.1}.to_vector

    it "#{a} should pass" do
      a.x.should eq 4.3
      a.y.should eq -4.2
      a.z.should eq 3.1
      a.w.should eq 0
      a.vector?.should be_true
      a.point?.should be_false
    end
  end

  describe "to_tuple returns a tuple with w = 0.0" do
    p = Vector.new(4, -4, 3)
    expected = {4.0, -4.0, 3.0, 0.0}

    it "is #{expected}" do
      p.to_tuple.should eq expected
    end
  end

  describe "Adding two vectors" do
    v1 = {3.0, -2.0, 5.0}.to_vector
    v2 = {-2.0, 3.0, 1.0}.to_vector
    expected = {1.0, 1.0, 6.0}.to_vector

    it "adds each element, returns a vector" do
      v1.add(v2).should eq expected
      typeof(v1.add(v2)).should eq Vector
    end
  end

  describe "Adding vector and point" do
    v1 = {3.0, -2.0, 5.0}.to_vector
    p2 = {-2.0, 3.0, 1.0}.to_point
    expected = {1.0, 1.0, 6.0}.to_point

    it "adds each element, returns a point" do
      v1.add(p2).should eq expected
      typeof(v1.add(p2)).should eq Point
    end
  end

  describe "Subtracting two vectors" do
    v1 = Vector.new(3, 2, 1)
    v2 = Vector.new(5, 6, 7)
    expected = Vector.new(-2, -4, -6)

    it "returns a vector" do
      v1.sub(v2).should eq expected
      typeof(v1.sub(v2)).should eq Vector
    end
  end

  describe "Subtracting a vector from the zero vector" do
    zero = Vector.new(0, 0, 0)
    v = Vector.new(1, -2, 3)
    expected = Vector.new(-1, 2, -3)

    it "returns a negated vector" do
      zero.sub(v).should eq expected
      typeof(zero.sub(v)).should eq Vector
    end
  end

  describe "Subtracting a point from a vector" do
    p = Vector.new(3, 2, 1)
    v = Point.new(5, 6, 7)
    expected = Point.new(2, 4, 6)

    it "returns another point" do
      v.sub(p).should eq expected
      typeof(v.sub(p)).should eq Point
    end
  end

  describe "Magnitude of vector(1, 0, 0)" do
    v = Vector.new(1, 0, 0)

    it "has magnitude 1" do
      v.magnitude.should eq 1.0
    end
  end

  describe "Magnitude of vector(0, 1, 0)" do
    v = Vector.new(0, 1, 0)

    it "has magnitude 1" do
      v.magnitude.should eq 1.0
    end
  end

  describe "Magnitude of vector(0, 0, 1)" do
    v = Vector.new(0, 0, 1)

    it "has magnitude 1" do
      v.magnitude.should eq 1.0
    end
  end

  describe "Magnitude of vector(1, 2, 3)" do
    v = Vector.new(1, 2, 3)

    it "has magnitude sqrt(14)" do
      v.magnitude.should eq 14.0**0.5
    end
  end

  describe "Magnitude of vector(-1, -2, -3)" do
    v = Vector.new(-1, -2, -3)

    it "has magnitude sqrt(14)" do
      v.magnitude.should eq 14.0**0.5
    end
  end

  describe "Normalize vector(4, 0, 0)" do
    v = Vector.new(4, 0, 0)

    it "gives (1, 0, 0)" do
      v.normalize.should eq Vector.new(1, 0, 0)
    end
  end

  describe "Normalize vector(1, 2, 3)" do
    v = Vector.new(1, 2, 3)

    it "gives (1/sqrt(14), 2/sqrt(24), 3/sqrt(14))" do
      v.normalize.should eq Vector.new(1/(14**0.5), 2/(14**0.5), 3/(14**0.5))
    end
  end

  describe "The magnitued of a normalized vector" do
    v = Vector.new(1, 2, 3)

    it "is 1" do
      v.normalize.magnitude.should eq 1.0
    end
  end

  describe "The dot product of two tuples" do
    a = Vector.new(1, 2, 3)
    b = Vector.new(2, 3, 4)
    expected = 20.0

    it "is the sum of the corresponding components of each vector" do
      a.dot(b).should eq expected
    end
  end

  describe "The cross product of two vectors" do
    a = Vector.new(1, 2, 3)
    b = Vector.new(2, 3, 4)

    it "gives a vector perpendicular to both vectors" do
      a.cross(b).should eq Vector.new(-1, 2, -1)
      b.cross(a).should eq Vector.new(1, -2, 1)
    end
  end

  describe "Reflecting a vector approaching at 45degrees" do
    v = Vector.new(1, -1, 0)
    normal = Vector.new(0, 1, 0)

    it "bounces at the same angle" do
      r = v.reflect(normal)
      r.should eq Vector.new(1, 1, 0)
    end
  end

  describe "Reflecting a vector off a slanted surface" do
    v = Vector.new(0, -1, 0)
    normal = Vector.new(Math.sqrt(2)/2, Math.sqrt(2)/2, 0)

    it "bounces with the same angle to the normal" do
      r = v.reflect(normal)
      r.should eq_vector Vector.new(1, 0, 0)
    end
  end
end
