require "./spec_helper"

describe "Canvas" do
  describe "creating a canvas" do
    width = 2
    height = 4
    c = Canvas.new(width, height)
    it "inits all pixels to color(0, 0, 0)" do
      c.width.should eq width
      c.height.should eq height

      expected = Color.new(0, 0, 0)

      (0...height).each do |y|
        (0...width).each do |x|
          c.at(x, y).should eq_color expected
        end
      end
    end
  end
end
