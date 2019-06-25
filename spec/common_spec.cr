require "./spec_helper"

describe "Common struct functions" do
  describe "Adding two vectors" do
    v1 = {3.0, -2.0, 5.0}.to_vector
    v2 = {-2.0, 3.0, 1.0}.to_vector
    expected = {1.0, 1.0, 6.0}.to_vector

    it "adds each element, returns a vector" do
      v1.add(v2).should eq expected
    end
  end

  describe "Adding two points" do
    v1 = {3.0, -2.0, 5.0}.to_point
    v2 = {-2.0, 3.0, 1.0}.to_point
    expected = {1.0, 1.0, 6.0}.to_point

    it "adds each element, returns a point" do
      v1.add(v2).should eq expected
    end
  end

  describe "Adding point and vector" do
    v1 = {3.0, -2.0, 5.0}.to_point
    v2 = {-2.0, 3.0, 1.0}.to_vector
    expected = {1.0, 1.0, 6.0}.to_point

    it "adds each element, returns a point" do
      v1.add(v2).should eq expected
    end
  end

  describe "Adding vector and point" do
    v1 = {3.0, -2.0, 5.0}.to_vector
    v2 = {-2.0, 3.0, 1.0}.to_point
    expected = {1.0, 1.0, 6.0}.to_point

    it "adds each element, returns a point" do
      v1.add(v2).should eq expected
    end
  end

  describe "Subtracting two vectors" do
    p1 = Vector.new(3, 2, 1)
    p2 = Vector.new(5, 6, 7)
    expected = Vector.new(-2, -4, -6)

    it "returns a vector" do
      p1.sub(p2).should eq expected
    end
  end

  describe "Subtracting two points" do
    p1 = Point.new(3, 2, 1)
    p2 = Point.new(5, 6, 7)
    expected = Vector.new(-2, -4, -6)

    it "returns a vector" do
      p1.sub(p2).should eq expected
    end
  end

  describe "Subtracting a vector from a point" do
    p = Point.new(3, 2, 1)
    v = Vector.new(5, 6, 7)
    expected = Point.new(-2, -4, -6)

    it "returns another point" do
      p.sub(v).should eq expected
    end
  end

  describe "Subtracting a point from a vector" do
    p = Vector.new(3, 2, 1)
    v = Point.new(5, 6, 7)
    expected = Point.new(-2, -4, -6)

    it "returns another point" do
      p.sub(v).should eq expected
    end
  end

  describe "Negating a Vector" do
    v = {1, -2, 3}.to_vector
    expected = {-1, 2, -3}.to_vector

    it "returns a negated vector" do
      (-v).should eq expected
    end
  end

  describe "Negating a Point" do
    v = {1, -2, 3}.to_point
    expected = {-1, 2, -3}.to_point

    it "returns a negated point" do
      (-v).should eq expected
    end
  end

  describe "Multiplying a vector by a scalar" do
    v = {1, -2, 3}.to_vector
    scalar = 3.5
    expected = {3.5, -7, 10.5}.to_vector

    it "returns tuple with each element multiplied by scalar" do
      v.mul(scalar).should eq expected
    end
  end

  describe "Multiplying a point by a scalar fraction" do
    v = {1, -2, 3}.to_point
    scalar = 0.5
    expected = {0.5, -1, 1.5}.to_point

    it "returns tuple with each element multiplied by scalar" do
      v.mul(scalar).should eq expected
    end
  end

  describe "Dividing a vector by a scalar" do
    # note: needed .0 because of strict typing :(
    v = {1.0, -2.0, 3.0}.to_vector
    scalar = 2.0
    expected = {0.5, -1, 1.5}.to_vector

    it "returns tuple with each element multiplied by scalar" do
      v.div(scalar).should eq expected
    end
  end

  describe "Dividing a point by a scalar" do
    # note: needed .0 because of strict typing :(
    v = {1.0, -2.0, 3.0}.to_point
    scalar = 2.0
    expected = {0.5, -1, 1.5}.to_point

    it "returns tuple with each element multiplied by scalar" do
      v.div(scalar).should eq expected
    end
  end
end
