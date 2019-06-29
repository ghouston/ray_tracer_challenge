require "../spec_helper"

include RayTracerChallenge::Adapters

describe "SubPixelStream" do
  describe "streaming a 1x1 canvas" do
    canvas = Canvas.new(1, 1)
    canvas.write(0, 0, Color.new(0.5, 0.25, 0.125))

    sub_pixel_stream = SubPixelStream.new(canvas)

    it "receives the red then green then blue parts" do
      sub_pixel_stream.more?.should be_true
      sub_pixel = sub_pixel_stream.receive
      sub_pixel.should eq SubPixel.new(0, 0, RGB::Red, 128)

      sub_pixel_stream.more?.should be_true
      sub_pixel = sub_pixel_stream.receive
      sub_pixel.should eq SubPixel.new(0, 0, RGB::Green, 64)

      sub_pixel_stream.more?.should be_true
      sub_pixel = sub_pixel_stream.receive
      sub_pixel.should eq SubPixel.new(0, 0, RGB::Blue, 32)

      sub_pixel_stream.more?.should be_false
    end
  end

  describe "streaming a 2x2 canvas" do
    canvas = Canvas.new(2, 2, Color.new(0.5, 0.25, 0.125))
    sub_pixel_stream = SubPixelStream.new(canvas)

    it "receives 4 red green blue parts" do
      canvas.each_index do |x, y|
        sub_pixel_stream.more?.should be_true
        sub_pixel = sub_pixel_stream.receive
        sub_pixel.should eq SubPixel.new(x, y, RGB::Red, 128)

        sub_pixel_stream.more?.should be_true
        sub_pixel = sub_pixel_stream.receive
        sub_pixel.should eq SubPixel.new(x, y, RGB::Green, 64)

        sub_pixel_stream.more?.should be_true
        sub_pixel = sub_pixel_stream.receive
        sub_pixel.should eq SubPixel.new(x, y, RGB::Blue, 32)
      end
      sub_pixel_stream.more?.should be_false
    end
  end
end
