require "./spec_helper"

describe "Tuple extensions" do
  describe "#to_color" do
    t = {0.2, 0.3, 0.4}
    c = t.to_color
    expected = Color.new(0.2, 0.3, 0.4)

    it "should return the correct Color" do
      c.should eq_color expected
    end
  end

  describe "#to_point" do
    t = {0.2, 0.3, 0.4}
    p = t.to_point
    expected = Point.new(0.2, 0.3, 0.4)

    it "should return the correct Point" do
      p.should eq expected
    end
  end

  describe "#to_vector" do
    t = {0.2, 0.3, 0.4}
    v = t.to_vector
    expected = Vector.new(0.2, 0.3, 0.4)

    it "should return the correct Vector" do
      v.should eq expected
    end
  end
end

describe "Float64 extensions" do
  describe "#clamp" do
    it "limits value" do
      1.5.clamp(1.0, 0.0).should eq 1.0
      1.0.clamp(1.0, 0.0).should eq 1.0
      0.5.clamp(1.0, 0.0).should eq 0.5
      0.0.clamp(1.0, 0.0).should eq 0.0
      -1.5.clamp(1.0, 0.0).should eq 0.0
    end
  end
  describe "#to_color_255" do
    it "converts % value to int 0-255" do
      0.0.to_color_255.should eq 0
      1.0.to_color_255.should eq 255
      0.5.to_color_255.should eq 128

      1.5.to_color_255.should eq 255
      -0.5.to_color_255.should eq 0
    end
  end
  describe "#equivalent" do
    it "compares floats as matching when they are very very close" do
      a = 1.0
      b = a + Float64::EPSILON
      c = a + Float64::EPSILON + Float64::EPSILON

      (a == b).should be_false
      a.equivalent(b).should be_true
      a.equivalent(c).should be_false

      m = 1.23456789012345 # see Float64::DIGITS
      n = 1.23456789012344

      m.equivalent(n).should be_false
    end
  end
end
