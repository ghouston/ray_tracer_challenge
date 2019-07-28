module RayTracerChallenge
  # A collection of Intersection sorted by t
  class Intersections
    def initialize(*args)
      @data = Array(Intersection).new(args.size)
      args.each { |i| @data << i }
      @data.sort!
    end

    def size
      @data.size
    end

    def [](index : Int)
      @data[index]
    end

    def hit
      @data.find(if_none: nil) { |i| i.t >= 0.0 }
    end
  end
end
