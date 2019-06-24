require "./spec_helper"

describe "Tuple math extension functions" do
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
end
