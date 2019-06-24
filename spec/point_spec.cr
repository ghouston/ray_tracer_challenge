require "./spec_helper"

describe "Point Tuple" do
  describe "A tuple with w=1.0 is a point" do
    a = {4.3, -4.2, 3.1, 1}

    it "#{a} should pass" do
      a.x.should eq 4.3
      a.y.should eq -4.2
      a.z.should eq 3.1
      a.w.should eq 1
      a.vector?.should be_false
      a.point?.should be_true
    end
  end

  describe "Tuple.point() creates tuuples with w = 1.0" do
    p = Tuple.point(4, -4, 3)
    expected = {4, -4, 3, 1}

    it "is #{expected}" do
      p.should eq expected
    end
  end
end
