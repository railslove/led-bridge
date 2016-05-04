require 'ws2812'
require 'colormath'

# This file is called led_strip.rb
# It contains the class LedStrip
class LedStrip
  attr_accessor :strip

  def initialize(led_count, led_pin)
    fail 'led_count missing' unless led_count
    fail 'led_pin missing' unless led_pin
    @strip = Ws2812::Basic.new led_count, led_pin
    @strip.open
  end

  def colors=(rgb_colors)
    rgb_colors.each.with_index do |color, index|
      next if color.nil? || color.empty?
      color = format('#%02X%02X%02X', *color) if color.is_a? Array

      led_color(index, ColorMath.hex_color(color))
    end

    update
  end

  private

  def update
    strip.show
  end

  def led_color(led_number, color)
    strip[led_number] = Ws2812::Color.new(color_to_array(color))
  end

  def color_to_array(color)
    %i(red green blue).inject([]) do |result, color_part|
      result << (color.public_send(color_part) * 255).to_i
    end
  end
end
