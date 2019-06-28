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
