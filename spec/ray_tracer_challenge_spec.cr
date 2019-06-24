require "./spec_helper"

DELTA = Float64::EPSILON

describe "Tuple" do
  describe "A tuple with w=1.0 is a point" do
    a = {4.3, -4.2, 3.1, 1.0}

    it "#{a} should pass" do
      a.x.should eq 4.3
      a.y.should eq -4.2
      a.z.should eq 3.1
      a.w.should eq 1.0
      a.vector?.should be_false
      a.point?.should be_true
    end
  end

  describe "A tuple with w=0 is a vector" do
    a = {4.3, -4.2, 3.1, 0.0}

    it "#{a} should pass" do
      a.x.should eq 4.3
      a.y.should eq -4.2
      a.z.should eq 3.1
      a.w.should eq 0.0
      a.vector?.should be_true
      a.point?.should be_false
    end
  end

  describe "Tuple.point() creates tuuples with w = 1.0" do
    p = Tuple.point(4, -4, 3)
    expected = {4.0, -4.0, 3.0, 1.0}

    it "is #{expected}" do
      p.should eq expected
    end
  end

  describe "Tuple.vector() creates tuuples with w = 0.0" do
    p = Tuple.vector(4, -4, 3)
    expected = {4.0, -4.0, 3.0, 0.0}

    it "is #{expected}" do
      p.should eq expected
    end
  end

  describe "Adding two tuples" do
    tuple1 = {3.0, -2.0, 5.0, 1.0}
    tuple2 = {-2.0, 3.0, 1.0, 0.0}
    expected = {1.0, 1.0, 6.0, 1.0}

    it "adds each element" do
      tuple1.add(tuple2).should eq expected
    end
  end

  describe "Subtracting two points" do
    p1 = Tuple.point(3, 2, 1)
    p2 = Tuple.point(5, 6, 7)
    expected = Tuple.vector(-2, -4, -6)

    it "returns a vector" do
      p1.sub(p2).should eq expected
    end
  end

  describe "Subtracting a vector from a point" do
    p = Tuple.point(3, 2, 1)
    v = Tuple.vector(5, 6, 7)
    expected = Tuple.point(-2, -4, -6)

    it "returns aonther point" do
      p.sub(v).should eq expected
    end
  end

  describe "Subtracting two vectors" do
    v1 = Tuple.vector(3, 2, 1)
    v2 = Tuple.vector(5, 6, 7)
    expected = Tuple.vector(-2, -4, -6)

    it "returns a vector" do
      v1.sub(v2).should eq expected
    end
  end

  describe "Subtracting a vector from the zero vector" do
    zero = Tuple.vector(0, 0, 0)
    v = Tuple.vector(1, -2, 3)
    expected = Tuple.vector(-1, 2, -3)

    it "returns a negated vector" do
      zero.sub(v).should eq expected
    end
  end

  describe "Negating a tuple" do
    v = {1, -2, 3, -4}
    expected = {-1, 2, -3, 4}

    it "returns a negated tuple" do
      (-v).should eq expected
    end
  end

  describe "Multiplying a tuple by a scalar" do
    v = {1, -2, 3, -4}
    scalar = 3.5
    expected = {3.5, -7, 10.5, -14}

    it "returns tuple with each element multiplied by scalar" do
      v.mul(scalar).should eq expected
    end
  end

  describe "Multiplying a tuple by a scalar fraction" do
    v = {1, -2, 3, -4}
    scalar = 0.5
    expected = {0.5, -1, 1.5, -2}

    it "returns tuple with each element multiplied by scalar" do
      v.mul(scalar).should eq expected
    end
  end

  describe "Dividing a tuple by a scalar" do
    # note: needed .0 because of strict typing :(
    v = {1.0, -2.0, 3.0, -4.0}
    scalar = 2.0
    expected = {0.5, -1, 1.5, -2}

    it "returns tuple with each element multiplied by scalar" do
      v.div(scalar).should eq expected
    end
  end

  describe "Magnitude of vector(1, 0, 0)" do
    v = Tuple.vector(1, 0, 0)

    it "has magnitude 1" do
      v.magnitude.should eq 1.0
    end
  end

  describe "Magnitude of vector(0, 1, 0)" do
    v = Tuple.vector(0, 1, 0)

    it "has magnitude 1" do
      v.magnitude.should eq 1.0
    end
  end

  describe "Magnitude of vector(0, 0, 1)" do
    v = Tuple.vector(0, 0, 1)

    it "has magnitude 1" do
      v.magnitude.should eq 1.0
    end
  end

  describe "Magnitude of vector(1, 2, 3)" do
    v = Tuple.vector(1, 2, 3)

    it "has magnitude sqrt(14)" do
      v.magnitude.should eq 14.0**0.5
    end
  end

  describe "Magnitude of vector(-1, -2, -3)" do
    v = Tuple.vector(-1, -2, -3)

    it "has magnitude sqrt(14)" do
      v.magnitude.should eq 14.0**0.5
    end
  end

  describe "Normalize vector(4, 0, 0)" do
    v = Tuple.vector(4, 0, 0)

    it "gives (1, 0, 0)" do
      v.normalize.should eq Tuple.vector(1, 0, 0)
    end
  end

  describe "Normalize vector(1, 2, 3)" do
    v = Tuple.vector(1, 2, 3)

    it "gives (1/sqrt(14), 2/sqrt(24), 3/sqrt(14))" do
      v.normalize.should eq Tuple.vector(1/(14**0.5), 2/(14**0.5), 3/(14**0.5))
    end
  end

  describe "The magnitued of a normalized vector" do
    v = Tuple.vector(1, 2, 3)

    it "is 1" do
      v.normalize.magnitude.should eq 1.0
    end
  end

  describe "The dot product of two tuples" do
    a = Tuple.vector(1, 2, 3)
    b = Tuple.vector(2, 3, 4)
    expected = 20.0

    it "is the sum of the corresponding components of each vector" do
      a.dot(b).should eq expected
    end
  end

  describe "The cross product of two vectors" do
    a = Tuple.vector(1, 2, 3)
    b = Tuple.vector(2, 3, 4)

    it "gives a vector perpendicular to both vectors" do
      a.cross(b).should eq Tuple.vector(-1, 2, -1)
      b.cross(a).should eq Tuple.vector(1, -2, 1)
    end
  end
end
