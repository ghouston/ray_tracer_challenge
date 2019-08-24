require "../ray_tracer_challenge"
include RayTracerChallenge

module Chapter5
  class RayCastSphere
    @camera : Point
    @wall_size : Float64
    @pixel_size : Float64
    @half : Float64

    def initialize
      @size = 100
      @canvas = Canvas.new(@size, @size)

      @camera = {0, 0, -5}.to_point

      @sphere = Sphere.new
      @sphere_radius = 1.0

      @wall_z = 10.0
      margin = 1
      @wall_size = ((@wall_z/@camera.z).abs + 1) * @sphere_radius * 2 + margin # e.g. 7
      @pixel_size = @wall_size/@size
      @half = @wall_size/2.0

      @color = Color.new(1, 0, 0)
    end

    def run
      ray_cast
      save_to_file("ch5_sphere.ppm")

      @canvas = Canvas.new(@size, @size)
      @sphere = Sphere.new(SquareMatrix.identity.scale(1, 0.5, 1))
      ray_cast
      save_to_file("ch5_shrink_on_y.ppm")

      @canvas = Canvas.new(@size, @size)
      @sphere = Sphere.new(SquareMatrix.identity.scale(0.5, 1, 1))
      ray_cast
      save_to_file("ch5_shrink_on_x.ppm")

      @canvas = Canvas.new(@size, @size)
      @sphere = Sphere.new(SquareMatrix.identity.scale(0.5, 1, 1).rotate_z(Math::PI/4.0))
      ray_cast
      save_to_file("ch5_shrink_and_rotate.ppm")

      @canvas = Canvas.new(@size, @size)
      @sphere = Sphere.new(SquareMatrix.identity.skew(1, 0, 0, 0, 0, 0))
      ray_cast
      save_to_file("ch5_skew.ppm")

      @canvas = Canvas.new(@size, @size)
      @sphere = Sphere.new(SquareMatrix.identity.scale(0.5, 1, 1).skew(1, 0, 0, 0, 0, 0))
      ray_cast
      save_to_file("ch5_shrink_and_skew.ppm")
    end

    def ray_cast
      @canvas.each_index do |x, y|
        wall_x = -@half + @pixel_size * x
        wall_y = -@half + @pixel_size * y
        target = {wall_x, wall_y, @wall_z}.to_point
        ray = Ray.new(@camera, target.sub(@camera).normalize)
        xs = ray.intersects(@sphere)
        if xs.hit
          @canvas.write(x, y, @color)
        end
      end
    end

    def save_to_file(file_name)
      directory = ARGV[0]? || "."
      file_path = File.join(directory, file_name)

      ppm_adapter = Adapters::PpmWriter.new(@canvas)
      File.open(file_path, "w") do |io|
        ppm_adapter.write(io)
      end
      puts "canvas saved to #{File.expand_path(file_path)}"
    end
  end
end

Chapter5::RayCastSphere.new.run
