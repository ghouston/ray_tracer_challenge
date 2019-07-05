require "./spec_helper"

describe "Common struct functions" do
  describe "Negating a Vector" do
    v = {1, -2, 3}.to_vector
    expected = {-1, 2, -3}.to_vector

    it "returns a negated vector" do
      (-v).should eq expected
      typeof(-v).should eq Vector
    end
  end

  describe "Negating a Point" do
    p = {1, -2, 3}.to_point
    expected = {-1, 2, -3}.to_point

    it "returns a negated point" do
      (-p).should eq expected
      typeof(-p).should eq Point
    end
  end

  describe "Multiplying a vector by a scalar" do
    v = {1, -2, 3}.to_vector
    scalar = 3.5
    expected = {3.5, -7, 10.5}.to_vector

    it "returns tuple with each element multiplied by scalar" do
      v.mul(scalar).should eq expected
      typeof(v.mul(scalar)).should eq Vector
    end
  end

  describe "Multiplying a point by a scalar fraction" do
    p = {1, -2, 3}.to_point
    scalar = 0.5
    expected = {0.5, -1, 1.5}.to_point

    it "returns tuple with each element multiplied by scalar" do
      p.mul(scalar).should eq expected
      typeof(p.mul(scalar)).should eq Point
    end
  end

  describe "Dividing a vector by a scalar" do
    v = {1.0, -2.0, 3.0}.to_vector
    scalar = 2
    expected = {0.5, -1, 1.5}.to_vector

    it "returns tuple with each element multiplied by scalar" do
      v.div(scalar).should eq expected
      typeof(v.div(scalar)).should eq Vector
    end
  end

  describe "Dividing a point by a scalar" do
    p = {1.0, -2.0, 3.0}.to_point
    scalar = 2
    expected = {0.5, -1, 1.5}.to_point

    it "returns tuple with each element multiplied by scalar" do
      p.div(scalar).should eq expected
      typeof(p.div(scalar)).should eq Point
    end
  end
end
