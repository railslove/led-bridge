require 'json'
require 'rack'

# require_relative 'lib/led_strip'

run -> (env) {
  data = JSON.parse(Rack::Request.new(env).body.read)

  color_array = Array.new(60){|_i| "#000000" }
  color_array[7..20] = Array.new(13){|i| data['0']['0'] }
  color_array[21..31] = Array.new(13){|i| data['0']['1'] }
  color_array[32..45] = Array.new(13){|i| data['1']['0'] }
  color_array[46..59] = Array.new(13){|i| data['1']['1'] }
  #
  # strip = LedStrip.new 60, 18
  # strip.colors color_array

  Rack::Response.new({ status: 'ok', data: color_array }.to_json, 200, 'Content-Type' => 'application/json')
}
