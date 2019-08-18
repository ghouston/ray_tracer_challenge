module RayTracerChallenge
  module Adapters
    class SubPixelStream
      def initialize(@canvas : Canvas)
        @sub_pixel_channel = Channel::Buffered(SubPixel).new(1)
        spawn sub_pixel_streamer
      end

      def more?
        !@sub_pixel_channel.closed?
      end

      # continuation fiber that feeds @sub_pixel_channel
      #
      #  Note: since PPM files start at the top left,
      #  the sub_pixel_streamer uses Canvas#flipped_each_with_index
      #  so that the canvas is streamed top to bottom.
      def sub_pixel_streamer
        @canvas.flipped_each_with_index do |x, y, pixel|
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
  end
end
