require 'ws2812'

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
      led_color(index, color)
    end

    update
  end

  private

  def update
    strip.show
  end

  def led_color(led_number, color)
    strip.set led_number, *format_color(color)
  end

  def format_color(color)
    if color.is_a? String
      color = [
        color[1..2].to_i(16),
        color[3..4].to_i(16),
        color[5..6].to_i(16)
      ]
    end

    color
  end
end
