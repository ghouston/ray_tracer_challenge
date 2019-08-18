require "../ray_tracer_challenge"
include RayTracerChallenge

require "./projectile.cr"
require "./environment.cr"

module Chapter2
  class PlotProjectile
    def initialize
      start = {0, 1, 0}.to_point
      velocity = {1, 1.8, 0}.to_vector.normalize.mul(11.25)
      @p = Projectile.new(start, velocity)

      gravity = {0, -0.1, 0}.to_vector
      wind = {-0.01, 0, 0}.to_vector
      @e = Environment.new(gravity, wind)

      @c = Canvas.new(900, 550)
    end

    def run
      file_path = ARGV[0]? || "ch2.ppm"

      white = Color.new(255, 255, 255)

      done = false
      while !done
        @p.tick(@e)
        if @p.position.y < 0
          done = true
        else
          @c.write(@p.position.x, @p.position.y, white)
        end
      end

      ppm_adapter = Adapters::PpmWriter.new(@c)
      File.open(file_path, "w") do |io|
        ppm_adapter.write(io)
      end
      puts "canvas saved to #{File.expand_path(file_path)}"
    end
  end
end

Chapter2::PlotProjectile.new.run
