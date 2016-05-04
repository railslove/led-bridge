require 'lib/led_strip'
require 'yaml'

config = YAML.load_file('config.yml')
led_strips = []

config.each do |c|
  led_strips << LedStrip.new(c.led_count, c.led_pin)
end

loop do
  colors = []
  30.times do |i|
    colors[i] = [rand(255), rand(255), rand(255)]
  end

  led_strips.first.setColors colors
  sleep 0.125
end
