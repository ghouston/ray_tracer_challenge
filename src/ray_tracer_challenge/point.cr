struct Tuple
  def to_point
    RayTracerChallenge::Point.new(self[0], self[1], self[2])
  end
end

module RayTracerChallenge
  struct Point < Common
    @w = 1.0

    def point?
      true
    end

    def to_tuple
      {x, y, z, w}
    end
  end
end
