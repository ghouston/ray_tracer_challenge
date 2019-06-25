require "spec"
require "../src/ray_tracer_challenge"

include RayTracerChallenge

module Spec
  # :nodoc:
  struct EqColorExpectation(T)
    def initialize(@expected_value : T)
      @delta = Float64::EPSILON
    end

    def match(actual_value)
      actual_value.color? &&
        (actual_value.red - @expected_value.red).abs <= @delta &&
        (actual_value.green - @expected_value.green).abs <= @delta &&
        (actual_value.blue - @expected_value.blue).abs <= @delta
    end

    def failure_message(actual_value)
      "Expected #{actual_value.inspect} to be within #{@delta} of #{@expected_value}"
    end

    def negative_failure_message(actual_value)
      "Expected #{actual_value.inspect} not to be within #{@delta} of #{@expected_value}"
    end
  end

  module Expectations
    def eq_color(value)
      Spec::EqColorExpectation.new value
    end
  end
end
