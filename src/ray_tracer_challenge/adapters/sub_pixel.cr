module RayTracerChallenge
  module Adapters
    struct SubPixel
      getter x, y, rgb, value

      def initialize(@x : Int32, @y : Int32, @rgb : RGB, @value : Int32)
      end
    end
  end
end
