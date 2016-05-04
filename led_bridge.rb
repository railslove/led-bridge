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

loop do
  colors = []
  led_strip.length.times do |i|
    colors[i] = [rand(255), rand(255), rand(255)]
  end

  led_strip.strip.colors = colors
  sleep 0.125
end
