require "../spec_helper"

include RayTracerChallenge::Adapters

describe "PpmWriter" do
  describe "with 1x1 canvas" do
    canvas = Canvas.new(1, 1)
    result = String.build do |io|
      PpmWriter.new(canvas).write(io)
    end

    it "should stream the PPM header" do
      stream = result.lines(chomp: false).each
      stream.next.should eq "P3\n"
      stream.next.should eq "1 1\n"
      stream.next.should eq "255\n"
    end
  end

  describe "1x1 canvas of white" do
    canvas = Canvas.new(1, 1, Color.new(1, 1, 1))
    result = String.build do |io|
      PpmWriter.new(canvas).write(io)
    end

    it "returns ppm file data" do
      stream = result.lines(chomp: false).each
      stream.next.should eq "P3\n"
      stream.next.should eq "1 1\n"
      stream.next.should eq "255\n"
      stream.next.should eq "255 255 255\n"
      stream.next.should eq "\n"
      stream.next.should eq Iterator::Stop::INSTANCE
    end
  end

  describe "3x4 canvas of white" do
    canvas = Canvas.new(3, 4, Color.new(1, 1, 1))
    result = String.build do |io|
      PpmWriter.new(canvas).write(io)
    end

    it "returns ppm header and data" do
      stream = result.lines(chomp: false).each
      stream.next.should eq "P3\n"
      stream.next.should eq "3 4\n"
      stream.next.should eq "255\n"
      stream.next.should eq "255 255 255 255 255 255 255 255 255\n"
      stream.next.should eq "255 255 255 255 255 255 255 255 255\n"
      stream.next.should eq "255 255 255 255 255 255 255 255 255\n"
      stream.next.should eq "255 255 255 255 255 255 255 255 255\n"
      stream.next.should eq "\n"
      stream.next.should eq Iterator::Stop::INSTANCE
    end
  end

  describe "5x3 canvas of some colors" do
    canvas = Canvas.new(5, 3)
    canvas.write(0, 0, Color.new(1.5, 0, 0))
    canvas.write(2, 1, Color.new(0, 0.5, 0))
    canvas.write(4, 2, Color.new(-0.5, 0, 1))
    result = String.build do |io|
      PpmWriter.new(canvas).write(io)
    end

    it "returns the correct data" do
      stream = result.lines(chomp: false).each
      stream.next.should eq "P3\n"
      stream.next.should eq "5 3\n"
      stream.next.should eq "255\n"
      stream.next.should eq "0 0 0 0 0 0 0 0 0 0 0 0 0 0 255\n"
      stream.next.should eq "0 0 0 0 0 0 0 128 0 0 0 0 0 0 0\n"
      stream.next.should eq "255 0 0 0 0 0 0 0 0 0 0 0 0 0 0\n"
      stream.next.should eq "\n"
      stream.next.should eq Iterator::Stop::INSTANCE
    end
  end

  describe "Wide canvas makes long lines in PPM files," do
    canvas = Canvas.new(10, 2)
    canvas.each_index do |x, y|
      canvas.write(x, y, Color.new(1, 0.8, 0.6))
    end
    result = String.build do |io|
      PpmWriter.new(canvas).write(io)
    end

    it "splits lines at 70 characters" do
      stream = result.lines(chomp: false).each
      stream.next.should eq "P3\n"
      stream.next.should eq "10 2\n"
      stream.next.should eq "255\n"
      #                     "--------10--------20--------30--------40--------50--------60--------70"
      stream.next.should eq "255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204\n"
      stream.next.should eq "153 255 204 153 255 204 153 255 204 153 255 204 153\n"
      stream.next.should eq "255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204\n"
      stream.next.should eq "153 255 204 153 255 204 153 255 204 153 255 204 153\n"
      stream.next.should eq "\n"
      stream.next.should eq Iterator::Stop::INSTANCE
    end
  end

  describe "Extra wide canvas makes long lines in PPM files," do
    canvas = Canvas.new(15, 1)
    canvas.each_index do |x, y|
      if x == 0
        canvas.write(x, y, Color.new(1, 0.5, 0.1))
      else
        canvas.write(x, y, Color.new(1, 0.5, 0.0))
      end
    end
    result = String.build do |io|
      PpmWriter.new(canvas).write(io)
    end

    it "splits lines at 70 characters on each line" do
      stream = result.lines(chomp: false).each
      stream.next.should eq "P3\n"
      stream.next.should eq "15 1\n"
      stream.next.should eq "255\n"
      #                     "--------10--------20--------30--------40--------50--------60--------70"
      stream.next.should eq "255 128 26 255 128 0 255 128 0 255 128 0 255 128 0 255 128 0 255 128 0\n"
      stream.next.should eq "255 128 0 255 128 0 255 128 0 255 128 0 255 128 0 255 128 0 255 128 0\n"
      stream.next.should eq "255 128 0\n"
      stream.next.should eq "\n"
      stream.next.should eq Iterator::Stop::INSTANCE
    end
  end
end
