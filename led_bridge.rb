require_relative './lib/led_strip'
require 'yaml'
require 'ostruct'

config = YAML.load_file('config.yml')
led_strips = []

config.each do |c|
  led_strips << OpenStruct.new(
    strip: LedStrip.new(c['led_count'], c['led_pin']),
    length: c['led_count']
  )
end

led_strip = led_strips.first
x = 60
dir = 1
loop do
  colors = []

  led_strip.length.times do |i|
    colors[i] = [0, (x % 255), 0]
  end

  if x == 255
    dir = -1
  elsif x == 60
    dir = 1
  end

  x += dir
  led_strip.strip.colors = colors
  # sleep 0.005
end
