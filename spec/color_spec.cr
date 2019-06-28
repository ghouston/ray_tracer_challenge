require "./spec_helper"

describe "Color struct" do
  describe "Colors are (red, green, blue)" do
    c = {-0.5, 0.4, 1.7}.to_color

    it "should:" do
      c.red.should eq -0.5
      c.green.should eq 0.4
      c.blue.should eq 1.7
    end
  end

  describe "Adding colors" do
    c1 = Color.new(0.9, 0.6, 0.75)
    c2 = Color.new(0.7, 0.1, 0.25)
    expected = Color.new(1.6, 0.7, 1.0)

    it "adds each element" do
      c1.add(c2).should eq_color expected
    end
  end

  describe "Subtracting colors" do
    c1 = Color.new(0.9, 0.6, 0.75)
    c2 = Color.new(0.7, 0.1, 0.25)
    expected = Color.new(0.2, 0.5, 0.5)

    it "subtracts each element" do
      c1.sub(c2).should eq_color expected
    end
  end

  describe "Multiply a color by a scalar" do
    c = Color.new(0.2, 0.3, 0.4)
    scalar = 2
    expected = Color.new(0.4, 0.6, 0.8)

    it "multiplies each element" do
      c.mul(scalar).should eq_color expected
    end
  end

  describe "Multiple colors" do
    c1 = Color.new(1, 0.2, 0.4)
    c2 = Color.new(0.9, 1, 0.1)
    expected = Color.new(0.9, 0.2, 0.04)

    it "multiples each element" do
      c1.mul(c2).should eq_color expected
    end
  end
end
