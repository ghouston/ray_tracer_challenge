module RayTracerChallenge
  class PpmStream
    enum RGB
      Red; Green; Blue
    end

    struct SubPixel
      getter x, y, rgb, value

      def initialize(@x : Int32, @y : Int32, @rgb : RGB, @value : Int32)
      end
    end

    class SubPixelStream
      def initialize(@canvas : Canvas)
        @sub_pixel_channel = Channel::Buffered(SubPixel).new(1)
        spawn sub_pixel_streamer
      end

      def more?
        !@sub_pixel_channel.closed?
      end

      # continuation fiber that feeds @sub_pixel_channel
      def sub_pixel_streamer
        @canvas.each_with_index do |x, y, pixel|
          @sub_pixel_channel.send(SubPixel.new(x, y, RGB::Red, pixel.red.to_color_255))
          @sub_pixel_channel.send(SubPixel.new(x, y, RGB::Green, pixel.green.to_color_255))
          @sub_pixel_channel.send(SubPixel.new(x, y, RGB::Blue, pixel.blue.to_color_255))
        end
        @sub_pixel_channel.close
      end

      def receive
        @sub_pixel_channel.receive
      end
    end

    def initialize(@canvas : Canvas)
      @sub_pixel_stream = SubPixelStream.new(@canvas)

      @line_channel = Channel::Buffered(String).new(1)
      spawn line_streamer
    end

    def more?
      !@line_channel.closed?
    end

    # contiunation fiber that feeds @line_channel
    def line_streamer
      stream_header
      stream_canvas
      @line_channel.send("")
      @line_channel.close
    end

    def stream_canvas
      # TODO: reduce cyclomatic complexity, maybe write directly to io instead.
      max_x = @canvas.width - 1
      line_length = 0
      line = ""
      while @sub_pixel_stream.more?
        sub_pixel = @sub_pixel_stream.receive
        x = sub_pixel.x
        value = sub_pixel.value
        rgb = sub_pixel.rgb

        if line_length + size(value) + 1 > 70
          @line_channel.send(line)
          line = ""
          line_length = 0
        end

        if line_length == 0
          line = sub_pixel.value.to_s
          line_length = size(value)
        else
          line = line + " " + sub_pixel.value.to_s
          line_length += size(value) + 1
        end

        if x == max_x && rgb == RGB::Blue
          @line_channel.send(line)
          line = ""
          line_length = 0
        end
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

    def next
      if more?
        data = @line_channel.receive
        data + "\n"
      else
        ""
      end
    end

    def stream_header
      @line_channel.send("P3")
      @line_channel.send("#{@canvas.width} #{@canvas.height}")
      @line_channel.send("255")
    end
  end
end
