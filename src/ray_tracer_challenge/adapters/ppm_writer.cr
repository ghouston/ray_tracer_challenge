module RayTracerChallenge
  module Adapters
    class PpmWriter
      MAX_LINE_LENGTH = 70

      def initialize(@canvas : Canvas)
        @sub_pixel_stream = SubPixelStream.new(@canvas)
      end

      def write(io : IO)
        @io = io
        io << "P3\n"
        io << @canvas.width << " " << @canvas.height << "\n"
        io << 255 << "\n"

        write_canvas(io)

        io << "\n"
      end

      def write_canvas(io)
        max_x = @canvas.width - 1
        line_length = 0

        while @sub_pixel_stream.more?
          sub_pixel = @sub_pixel_stream.receive
          x = sub_pixel.x
          value = sub_pixel.value
          rgb = sub_pixel.rgb

          line_length = split_line(line_length, value, io)
          line_length = write_sub_pixel(line_length, value, io)
          line_length = write_end_line(line_length, x, max_x, rgb, io)
        end
      end

      private def split_line(line_length, value, io)
        if line_length + size(value) + 1 > MAX_LINE_LENGTH
          io << "\n"
          0
        else
          line_length
        end
      end

      private def write_sub_pixel(line_length, value, io)
        if line_length == 0
          io << value
          size(value)
        else
          io << " " << value
          line_length + size(value) + 1
        end
      end

      private def write_end_line(line_length, x, max_x, rgb, io)
        if x == max_x && rgb == RGB::Blue
          io << "\n"
          0
        else
          line_length
        end
      end

      private def size(value : Int32)
        if value > 99
          3
        elsif value > 9
          2
        else
          1
        end
      end
    end
  end
end
