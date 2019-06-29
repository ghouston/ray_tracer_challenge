struct Tuple
  def to_color
    Color.new(self[0], self[1], self[2])
  end

  def to_point
    RayTracerChallenge::Point.new(self[0], self[1], self[2])
  end

  def to_vector
    RayTracerChallenge::Vector.new(self[0], self[1], self[2])
  end
end

struct Float64
  def clamp(max, min)
    if self > max
      max
    elsif self < min
      min
    else
      self
    end
  end

  def to_color_255
    (clamp(1.0, 0.0) * 255).round.to_i
  end
end
