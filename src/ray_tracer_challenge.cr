require "./ray_tracer_challenge/canvas.cr"
require "./ray_tracer_challenge/color.cr"
require "./ray_tracer_challenge/point.cr"
require "./ray_tracer_challenge/tuple_math.cr"
require "./ray_tracer_challenge/vector.cr"

module RayTracerChallenge
  VERSION = "0.1.0"

  # for now, everything is implemented as extensions to the Tuple class.
end

struct Tuple
  # Crystal notes: #extend inserts into the meta-type ancestor chain
  # and thus it is used to add class methods. #include inserts into
  # the type hierarchy, adding instance methods.
  # ref: https://github.com/crystal-lang/crystal/issues/5082

  extend RayTracerChallenge::TupleMath::ClassMethods
  include RayTracerChallenge::TupleMath

  extend RayTracerChallenge::Point::ClassMethods
  include RayTracerChallenge::Point

  extend RayTracerChallenge::Vector::ClassMethods
  include RayTracerChallenge::Vector

  extend RayTracerChallenge::Color::ClassMethods
  include RayTracerChallenge::Color
end
