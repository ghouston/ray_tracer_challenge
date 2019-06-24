module RayTracerChallenge
  module Point
    # note: TupleMath is included in Tuple and it
    #       contains methods related to Point operations.

    module ClassMethods
      def point(x, y, z)
        {x.to_f, y.to_f, z.to_f, 1.0}
      end
    end

    def point?
      size == 4 && w == 1.0
    end
  end
end
