class Projectile
  property position : Point, velocity : Vector

  def initialize(@position, @velocity)
  end

  def tick(e : Environment)
    @position = @position.add(@velocity)
    @velocity = @velocity.add(e.gravity).add(e.wind)
  end

  def report
    puts "position: #{@position}"
  end
end
