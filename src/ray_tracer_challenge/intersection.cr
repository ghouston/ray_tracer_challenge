module RayTracerChallenge
  class Intersection
    getter t : Float64, object : Sphere

    def initialize(_t, @object)
      @t = _t.to_f
    end
  end

  class Intersections
    def initialize(*args)
      @data = Array(Intersection).new(args.size)
      args.each { |i| @data << i }
    end

    def size
      @data.size
    end

    def [](index : Int)
      @data[index]
    end
  end
end
