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
        actual_value.red.equivalent(@expected_value.red) &&
        actual_value.green.equivalent(@expected_value.green) &&
        actual_value.blue.equivalent(@expected_value.blue)
    end

    def failure_message(actual_value)
      "Expected #{actual_value.inspect} to be within #{@delta} of #{@expected_value}"
    end

    def negative_failure_message(actual_value)
      "Expected #{actual_value.inspect} not to be within #{@delta} of #{@expected_value}"
    end
  end

  struct EqPointExpectation(Point)
    def initialize(@expected_value : Point, @delta : Float64)
    end

    def match(actual_value)
      return false unless actual_value.x.equivalent(@expected_value.x, @delta)
      return false unless actual_value.y.equivalent(@expected_value.y, @delta)
      actual_value.z.equivalent(@expected_value.z, @delta)
    end

    def failure_message(actual_value)
      "Expected: #{@expected_value}\n" +
        "     got: #{actual_value}\n" +
        "didn't match within delta of #{@delta}"
    end

    def negative_failure_message(actual_value)
      "Expected: #{@expected_value}\n" +
        "     got: #{actual_value}\n" +
        "should not match within delta of #{@delta}"
    end
  end

  struct EqVectorExpectation(Vector)
    def initialize(@expected_value : Vector, @delta : Float64)
    end

    def match(actual_value)
      return false unless actual_value.x.equivalent(@expected_value.x, @delta)
      return false unless actual_value.y.equivalent(@expected_value.y, @delta)
      actual_value.z.equivalent(@expected_value.z, @delta)
    end

    def failure_message(actual_value)
      "Expected: #{@expected_value}\n" +
        "     got: #{actual_value}\n" +
        "didn't match within delta of #{@delta}"
    end

    def negative_failure_message(actual_value)
      "Expected: #{@expected_value}\n" +
        "     got: #{actual_value}\n" +
        "should not match within delta of #{@delta}"
    end
  end

  struct EqMatrixExpectation(T)
    def initialize(@expected_value : T, @delta : Float64)
      @row = 0
      @col = 0
    end

    def match(actual_value)
      return false if actual_value.width != @expected_value.width

      (0...actual_value.width).each do |row|
        (0...actual_value.width).each do |col|
          @row = row
          @col = col
          return false unless actual_value.at(row, col).equivalent(@expected_value.at(row, col), @delta)
        end
      end
      true
    end

    def failure_message(actual_value)
      "Expected [#{@row},#{@col}] #{actual_value.at(@row, @col)} to be within #{@delta} of #{@expected_value.at(@row, @col)}"
    end

    def negative_failure_message(actual_value)
      "Expected [#{@row},#{@col}] #{actual_value.at(@row, @col)} not to be within #{@delta} of #{@expected_value.at(@row, @col)}"
    end
  end

  module Expectations
    def eq_color(value)
      Spec::EqColorExpectation.new value
    end

    def eq_matrix(value, delta = Float64::EPSILON)
      Spec::EqMatrixExpectation.new value, delta
    end

    def eq_point(value, delta = Float64::EPSILON)
      Spec::EqPointExpectation.new value, delta
    end

    def eq_vector(value, delta = Float64::EPSILON)
      Spec::EqVectorExpectation.new value, delta
    end
  end
end
