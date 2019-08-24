require "../ray_tracer_challenge"
include RayTracerChallenge

module Chapter4
  class ClockFace
    def initialize
      @size = 100
      @c = Canvas.new(@size, @size)
    end

    def run
      draw_clock
      save_to_file
    end

    def draw_clock
      white = Color.new(1, 1, 1)

      origin = {0, 0, 0}.to_point

      (0..11).each do |i|
        transform = SquareMatrix.identity
          .translate(0, @size * 0.4, 0)
          .rotate_z(-i * Math::PI/6.0)
          .translate(@size/2, @size/2, 0)
        point = transform.mul(origin)
        @c.write(point.x, point.y, white)
      end
    end

    def save_to_file
      file_path = ARGV[0]? || "ch4.ppm"

      ppm_adapter = Adapters::PpmWriter.new(@c)
      File.open(file_path, "w") do |io|
        ppm_adapter.write(io)
      end
      puts "canvas saved to #{File.expand_path(file_path)}"
    end
  end
end

Chapter4::ClockFace.new.run
