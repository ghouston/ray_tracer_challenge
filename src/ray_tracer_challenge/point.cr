module RayTracerChallenge
  module Point
    # note: TupleMath is included in Tuple and it
    #       contains methods related to Point operations.

    module ClassMethods
      def point(x : Float64, y : Float64, z : Float64)
        {x, y, z, 1.0}
      end
    end

    def point?
      size == 4 && w == 1.0
    end
  end
end
