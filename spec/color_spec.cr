require "./spec_helper"

describe "Color Tuple" do
  describe "Colors are (red, green, blue) tuples" do
    c = Tuple.color(-0.5, 0.4, 1.7)

    it "should:" do
      c.red.should eq -0.5
      c.green.should eq 0.4
      c.blue.should eq 1.7
    end
  end

  describe "Adding colors" do
    c1 = Tuple.color(0.9, 0.6, 0.75)
    c2 = Tuple.color(0.7, 0.1, 0.25)
    expected = Tuple.color(1.6, 0.7, 1.0)

    it "adds each element" do
      c1.add(c2).should eq_color expected
    end
  end

  describe "Subtracting colors" do
    c1 = Tuple.color(0.9, 0.6, 0.75)
    c2 = Tuple.color(0.7, 0.1, 0.25)
    expected = Tuple.color(0.2, 0.5, 0.5)

    it "subtracts each element" do
      c1.sub(c2).should eq_color expected
    end
  end

  describe "Multiply a color by a scalar" do
    c = Tuple.color(0.2, 0.3, 0.4)

    it "multiplies each elemet" do
      c.color_mul(2).should eq_color Tuple.color(0.4, 0.6, 0.8)
    end
  end
end
