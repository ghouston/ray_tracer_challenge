module RayTracerChallenge
  class Intersection
    getter t : Float64, object : Sphere

    def initialize(_t, @object)
      @t = _t.to_f
    end

    def <=>(other : Intersection)
      t <=> other.t
    end
  end
end
