require "./spec_helper"

describe "Canvas" do
  describe "creating a canvas" do
    width = 10
    height = 20
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

  describe "writing pixels to a canvas" do
    c = Canvas.new(10, 20)
    red = Color.new(1, 0, 0)

    it "should update pixel" do
      c.write(2, 3, red)
      c.at(2, 3).should eq_color red
    end
  end
end
